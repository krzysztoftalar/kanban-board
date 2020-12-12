using Application.Dtos;
using MediatR;

namespace Application.Services.Board.Queries.GetBoard
{
    public class GetBoardQuery : IRequest<BoardDto>
    {
        public int Id { get; set; }
    }
}