using System.Threading;
using System.Threading.Tasks;
using Domain.Entities;
using MediatR;
using Microsoft.AspNetCore.Identity;

namespace Application.Services.User.Commands.Logout
{
    public class LogoutUserCommandHandler : IRequestHandler<LogoutUserCommand>
    {
        private readonly SignInManager<AppUser> _signInManager;

        public LogoutUserCommandHandler(SignInManager<AppUser> signInManager)
        {
            _signInManager = signInManager;
        }

        public async Task<Unit> Handle(LogoutUserCommand request, CancellationToken cancellationToken)
        {
            await _signInManager.SignOutAsync();
            
            return Unit.Value;
        }
    }
}