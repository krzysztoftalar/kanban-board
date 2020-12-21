using Application.Validators;
using FluentValidation;

namespace Application.Services.User.Commands.Register
{
    public class RegisterUserCommandValidator : AbstractValidator<RegisterUserCommand>
    {
        public RegisterUserCommandValidator()
        {
            RuleFor(x => x.UserName).NotEmpty();
            RuleFor(x => x.Email).NotEmpty().EmailAddress();
            RuleFor(x => x.Password).Password();
        }
    }
}