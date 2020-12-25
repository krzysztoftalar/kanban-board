using FluentValidation;

namespace Application.Services.Column.Commands.EditColumn
{
    public class EditColumnCommandValidator : AbstractValidator<EditColumnCommand>
    {
        public EditColumnCommandValidator()
        {
            RuleFor(x => x.ColumnId).NotNull();
            RuleFor(x => x.Title).NotEmpty().MaximumLength(100);
        }
    }
}