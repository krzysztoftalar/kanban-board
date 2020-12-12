using MediatR;

namespace Application.Services.Column.Commands.UpdateColumnTitle
{
    public class UpdateColumnTitleCommand : IRequest
    {
        public int ColumnId { get; set; }
        public string Title { get; set; }
    }
}