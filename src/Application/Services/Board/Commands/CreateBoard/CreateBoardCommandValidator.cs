using FluentValidation;

namespace Application.Services.Board.Commands.CreateBoard
{
    public class CreateBoardCommandValidator : AbstractValidator<CreateBoardCommand>
    {
        public CreateBoardCommandValidator()
        {
            RuleFor(x => x.Title).NotEmpty().MaximumLength(100);
            RuleFor(x => x.TemplateId).NotNull();
        }
    }
}