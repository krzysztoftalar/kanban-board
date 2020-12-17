using System.Threading.Tasks;
using Application.Dtos;
using Application.Services.Board.Commands.CreateBoard;
using Application.Services.Board.Commands.DeleteBoard;
using Application.Services.Board.Queries.GetBoard;
using Application.Services.Board.Queries.GetBoards;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace WebUI.Controllers
{
    public class BoardsController : BaseController
    {
        [HttpGet("{id}")]
        public async Task<ActionResult<BoardDto>> GetBoard(int id)
        {
            return await Mediator.Send(new GetBoardQuery { Id = id });
        }

        [HttpPost]
        public async Task<ActionResult<int>> CreateBoard([FromBody] CreateBoardCommand command)
        {
            return await Mediator.Send(command);
        }

        [HttpGet]
        public async Task<ActionResult<BoardsEnvelope>> GetBoards([FromQuery] GetBoardsQuery query)
        {
            return await Mediator.Send(query);
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<Unit>> DeleteBoard(int id)
        {
            return await Mediator.Send(new DeleteBoardCommand { BoardId = id });
        }
    }
}