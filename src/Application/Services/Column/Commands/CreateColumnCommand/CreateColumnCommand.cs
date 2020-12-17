using MediatR;

namespace Application.Services.Column.Commands.CreateColumnCommand
{
    public class CreateColumnCommand : IRequest
    {
        public int BoardId { get; set; }
        public int ColumnIndex { get; set; }
        public string Title { get; set; }
    }
}