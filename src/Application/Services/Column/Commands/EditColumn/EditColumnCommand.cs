using MediatR;

namespace Application.Services.Column.Commands.EditColumn
{
    public class EditColumnCommand : IRequest
    {
        public int ColumnId { get; set; }
        public string Title { get; set; }
    }
}