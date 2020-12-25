using MediatR;

namespace Application.Services.Board.Commands.EditBoard
{
    public class EditBoardCommand : IRequest
    {
        public int BoardId { get; set; }
        public string Title { get; set; }
    }
}