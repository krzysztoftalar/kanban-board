using System;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Application.Errors;
using Application.Helpers;
using Application.Interfaces;
using Domain.Entities;
using MediatR;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace Application.Services.User.Commands.Logout
{
    public class LogoutUserCommandHandler : IRequestHandler<LogoutUserCommand>
    {
        private readonly SignInManager<AppUser> _signInManager;
        private readonly IAppDbContext _context;

        public LogoutUserCommandHandler(SignInManager<AppUser> signInManager, IAppDbContext context)
        {
            _signInManager = signInManager;
            _context = context;
        }

        public async Task<Unit> Handle(LogoutUserCommand request, CancellationToken cancellationToken)
        {
            var refreshToken = await _context.RefreshTokens
                .SingleOrDefaultAsync(x => x.Token == request.RefreshToken, cancellationToken);

            if (refreshToken == null)
            {
                throw new RestException(HttpStatusCode.NotFound, new { Error = "Not found refreshToken." });
            }

            refreshToken.Revoked = DateTime.UtcNow;

            var success = await _context.SaveChangesAsync(cancellationToken) > 0;

            if (success)
            {
                await _signInManager.SignOutAsync();

                return Unit.Value;
            }

            throw new Exception(Constants.ServerSavingError);
        }
    }
}