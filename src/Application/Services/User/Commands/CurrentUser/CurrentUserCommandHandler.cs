using System;
using System.Linq;
using System.Net;
using System.Security.Claims;
using System.Threading;
using System.Threading.Tasks;
using Application.Dtos;
using Application.Errors;
using Application.Helpers;
using Application.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Net.Http.Headers;
using AppContext = Application.Infrastructure.AppContext;

namespace Application.Services.User.Commands.CurrentUser
{
    public class CurrentUserCommandHandler : IRequestHandler<CurrentUserCommand, UserDto>
    {
        private readonly IJwtGenerator _jwtGenerator;
        private readonly IAppDbContext _context;

        public CurrentUserCommandHandler(IJwtGenerator jwtGenerator, IAppDbContext context)
        {
            _jwtGenerator = jwtGenerator;
            _context = context;
        }

        public async Task<UserDto> Handle(CurrentUserCommand request, CancellationToken cancellationToken)
        {
            var token = AppContext.Current.Request.Headers[HeaderNames.Authorization].ToString().Replace("Bearer ", "");

            var principal = _jwtGenerator.GetPrincipalFromExpiredToken(token);

            var username = principal.Claims.FirstOrDefault(x => x.Type == ClaimTypes.NameIdentifier)?.Value;

            var user = await _context.Users
                .Where(x => x.UserName == username)
                .Include(x => x.RefreshTokens)
                .SingleOrDefaultAsync(x => x.RefreshTokens.Any(y => y.Token == request.RefreshToken),
                    cancellationToken);

            if (user == null)
            {
                AppContext.Current.Response.Headers.Add(Constants.TokenExpired, "true");
                throw new RestException(HttpStatusCode.Unauthorized);
            }

            var oldToken = user.RefreshTokens.SingleOrDefault(x => x.Token == request.RefreshToken);

            if (oldToken != null && !oldToken.IsActive)
            {
                AppContext.Current.Response.Headers.Add(Constants.TokenExpired, "true");
                throw new RestException(HttpStatusCode.Unauthorized);
            }

            if (oldToken != null)
            {
                oldToken.Revoked = DateTime.UtcNow;
            }

            var newRefreshToken = _jwtGenerator.GenerateRefreshToken(user);

            await _context.RefreshTokens.AddAsync(newRefreshToken, cancellationToken);

            var revokedTokens = user.RefreshTokens.Where(x => x.IsExpired);
            
            _context.RefreshTokens.RemoveRange(revokedTokens);

            var success = await _context.SaveChangesAsync(cancellationToken) > 0;

            if (success)
            {
                return new UserDto
                {
                    UserName = user.UserName,
                    Token = _jwtGenerator.GenerateAccessToken(user),
                    RefreshToken = newRefreshToken.Token
                };
            }

            throw new Exception(Constants.ServerSavingError);
        }
    }
}