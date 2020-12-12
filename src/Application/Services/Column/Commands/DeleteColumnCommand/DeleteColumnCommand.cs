using MediatR;

namespace Application.Services.Column.Commands.DeleteColumnCommand
{
    public class DeleteColumnCommand : IRequest
    {
        public int ColumnId { get; set; }
    }
}