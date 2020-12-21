using FluentValidation;

namespace Application.Services.Column.Commands.CreateColumnCommand
{
    public class CreateColumnCommandValidator : AbstractValidator<CreateColumnCommand>
    {
        public CreateColumnCommandValidator()
        {
            RuleFor(x => x.Title).NotEmpty().MaximumLength(100);
            RuleFor(x => x.BoardId).NotNull();
            RuleFor(x => x.ColumnIndex).NotNull();
        }
    }
}