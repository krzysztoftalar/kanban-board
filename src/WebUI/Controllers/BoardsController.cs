using System.Threading.Tasks;
using Application.Dtos;
using Application.Services.Board.Queries.GetBoard;
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
    }
}