using FluentValidation;

namespace Application.Services.User.Commands.Logout
{
    public class LogoutUserCommandValidator : AbstractValidator<LogoutUserCommand>
    {
        public LogoutUserCommandValidator()
        {
            RuleFor(x => x.RefreshToken).NotEmpty();
        }
    }
}