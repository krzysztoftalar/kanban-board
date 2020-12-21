using FluentValidation;

namespace Application.Services.Column.Commands.UpdateColumnTitle
{
    public class UpdateColumnTitleCommandValidator : AbstractValidator<UpdateColumnTitleCommand>
    {
        public UpdateColumnTitleCommandValidator()
        {
            RuleFor(x => x.Title).NotEmpty().MaximumLength(100);
            RuleFor(x => x.ColumnId).NotNull();
        }
    }
}