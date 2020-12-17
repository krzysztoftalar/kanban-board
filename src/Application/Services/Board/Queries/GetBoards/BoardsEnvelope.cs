using System.Collections.Generic;
using Application.Dtos;

namespace Application.Services.Board.Queries.GetBoards
{
    public class BoardsEnvelope
    {
        public List<BoardDto> Boards { get; set; }
        public int BoardsCount { get; set; }
    }
}