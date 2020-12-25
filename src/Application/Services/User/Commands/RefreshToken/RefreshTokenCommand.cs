using Application.Dtos;
using MediatR;

namespace Application.Services.User.Commands.RefreshToken
{
    public class RefreshTokenCommand : IRequest<UserDto>
    {
    }
}