using FluentValidation;

namespace Application.Services.Column.Commands.UpdateColumnIndex
{
    public class UpdateColumnIndexCommandValidator : AbstractValidator<UpdateColumnIndexCommand>
    {
        public UpdateColumnIndexCommandValidator()
        {
            RuleFor(x => x.OldIndex).NotNull();
            RuleFor(x => x.NewIndex).NotNull();
            RuleFor(x => x.ColumnId).NotNull();
            RuleFor(x => x.BoardId).NotNull();
        }
    }
}