using FluentValidation;

namespace Application.Services.User.Commands.CurrentUser
{
    public class CurrentUserCommandValidator : AbstractValidator<CurrentUserCommand>
    {
        public CurrentUserCommandValidator()
        {
            RuleFor(x => x.RefreshToken).NotEmpty();
        }
    }
}