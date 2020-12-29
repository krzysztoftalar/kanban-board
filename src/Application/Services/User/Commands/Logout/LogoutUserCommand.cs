using MediatR;

namespace Application.Services.User.Commands.Logout
{
    public class LogoutUserCommand : IRequest
    {
        public string RefreshToken { get; set; }
    }
}