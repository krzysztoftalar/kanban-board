using MediatR;

namespace Application.Services.Column.Commands.UpdateColumnIndex
{
    public class UpdateColumnIndexCommand : IRequest
    {
        public int OldIndex { get; set; }
        public int NewIndex { get; set; }
        public int ColumnId { get; set; }
        public int BoardId { get; set; }
    }
}