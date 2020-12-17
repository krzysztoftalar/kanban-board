using MediatR;

namespace Application.Services.Board.Queries.GetBoards
{
    public class GetBoardsQuery : IRequest<BoardsEnvelope>
    {
        public int? Skip { get; set; }
        public int? Limit { get; set; }
    }
}