
using FluentValidation;

namespace Application.Services.Card.Commands.UpdateCardIndex
{
    public class UpdateCardIndexCommandValidator : AbstractValidator<UpdateCardIndexCommand>
    {
        public UpdateCardIndexCommandValidator()
        {
            RuleFor(x => x.OldCardIndex).NotNull();
            RuleFor(x => x.NewCardIndex).NotNull();
            RuleFor(x => x.OldColumnIndex).NotNull();
            RuleFor(x => x.NewColumnIndex).NotNull();
            RuleFor(x => x.CardId).NotNull();
            RuleFor(x => x.BoardId).NotNull();
        }
    }
}