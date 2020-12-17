using MediatR;

namespace Application.Services.Board.Commands.DeleteBoard
{
    public class DeleteBoardCommand : IRequest
    {
        public int BoardId { get; set; }
    }
}