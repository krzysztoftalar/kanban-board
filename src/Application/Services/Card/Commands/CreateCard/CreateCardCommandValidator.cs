using FluentValidation;

namespace Application.Services.Card.Commands.CreateCard
{
    public class CreateCardCommandValidator : AbstractValidator<CreateCardCommand>
    {
        public CreateCardCommandValidator()
        {
            RuleFor(x => x.Title).NotEmpty().MaximumLength(100);
            RuleFor(x => x.ColumnId).NotNull();
            RuleFor(x => x.CardIndex).NotNull();
        }
    }
}