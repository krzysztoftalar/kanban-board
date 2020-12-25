using System;
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

namespace Application.Services.User.Queries.CurrentUser
{
    public class CurrentUserQueryHandler : IRequestHandler<CurrentUserQuery, UserDto>
    {
        private readonly IJwtGenerator _jwtGenerator;
        private readonly IUserAccessor _userAccessor;
        private readonly ICookieService _cookieService;
        private readonly IAppDbContext _context;
        private readonly UserManager<AppUser> _userManager;

        public CurrentUserQueryHandler(UserManager<AppUser> userManager, IJwtGenerator jwtGenerator,
            IUserAccessor userAccessor, ICookieService cookieService, IAppDbContext context)
        {
            _userManager = userManager;
            _jwtGenerator = jwtGenerator;
            _userAccessor = userAccessor;
            _cookieService = cookieService;
            _context = context;
        }

        public async Task<UserDto> Handle(CurrentUserQuery request, CancellationToken cancellationToken)
        {
            var user = await _userManager.FindByNameAsync(_userAccessor.GetCurrentUsername());
            
            if (user == null)
            {
                throw new RestException(HttpStatusCode.Unauthorized);
            }

            var refreshToken = _jwtGenerator.GenerateRefreshToken(user);

            await _context.RefreshTokens.AddAsync(refreshToken, cancellationToken);
            
            var success = await _context.SaveChangesAsync(cancellationToken) > 0;

            if (success)
            {
                _cookieService.SetCookieToken(refreshToken.Token);

                return new UserDto
                {
                    UserName = user.UserName,
                    Token = _jwtGenerator.CreateToken(user)
                };
            }

            throw new Exception(Constants.ServerSavingError);
        }
    }
}