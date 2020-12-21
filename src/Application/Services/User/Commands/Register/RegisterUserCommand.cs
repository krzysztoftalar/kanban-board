using Application.Dtos;
using MediatR;

namespace Application.Services.User.Commands.Register
{
    public class RegisterUserCommand : IRequest<UserDto>
    {
        public string UserName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
    }
}