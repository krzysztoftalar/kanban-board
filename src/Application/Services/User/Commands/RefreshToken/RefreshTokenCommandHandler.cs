using System;
using System.Linq;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Application.Dtos;
using Application.Errors;
using Application.Helpers;
using Application.Interfaces;
using Domain.Entities;
using MediatR;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using AppContext = Application.Infrastructure.AppContext;

namespace Application.Services.User.Commands.RefreshToken
{
    public class RefreshTokenCommandHandler : IRequestHandler<RefreshTokenCommand, UserDto>
    {
        private readonly IUserAccessor _userAccessor;
        private readonly IJwtGenerator _jwtGenerator;
        private readonly ICookieService _cookieService;
        private readonly IAppDbContext _context;

        public RefreshTokenCommandHandler(IUserAccessor userAccessor, IJwtGenerator jwtGenerator,
            ICookieService cookieService, IAppDbContext context)
        {
            _userAccessor = userAccessor;
            _jwtGenerator = jwtGenerator;
            _cookieService = cookieService;
            _context = context;
        }

        public async Task<UserDto> Handle(RefreshTokenCommand request, CancellationToken cancellationToken)
        {
            var user = await _context.Users
                .Include(x => x.RefreshTokens)
                .FirstOrDefaultAsync(x => x.UserName == _userAccessor.GetCurrentUsername(), cancellationToken);

            if (user == null)
            {
                throw new RestException(HttpStatusCode.Unauthorized);
            }

            var token = AppContext.Current.Request.Cookies
                .SingleOrDefault(x => x.Key == Constants.RefreshCookieToken);

            var oldToken = user.RefreshTokens.SingleOrDefault(x => x.Token == token.Value);

            if (oldToken != null && !oldToken.IsActive)
            {
                throw new RestException(HttpStatusCode.Unauthorized);
            }

            if (oldToken != null)
            {
                oldToken.Revoked = DateTime.UtcNow;
            }

            var newRefreshToken = _jwtGenerator.GenerateRefreshToken(user);

            await _context.RefreshTokens.AddAsync(newRefreshToken, cancellationToken);

            var success = await _context.SaveChangesAsync(cancellationToken) > 0;

            if (success)
            {
                _cookieService.SetCookieToken(newRefreshToken.Token);

                return new UserDto
                {
                    UserName = user.UserName,
                    Token = _jwtGenerator.CreateToken(user),
                };
            }

            throw new Exception(Constants.ServerSavingError);
        }
    }
}