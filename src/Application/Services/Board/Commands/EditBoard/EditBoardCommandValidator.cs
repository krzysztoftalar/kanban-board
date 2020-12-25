using FluentValidation;

namespace Application.Services.Board.Commands.EditBoard
{
    public class EditBoardCommandValidator : AbstractValidator<EditBoardCommand>
    {
        public EditBoardCommandValidator()
        {
            RuleFor(x => x.BoardId).NotNull();
            RuleFor(x => x.Title).NotEmpty().MaximumLength(100);
        }
    }
}