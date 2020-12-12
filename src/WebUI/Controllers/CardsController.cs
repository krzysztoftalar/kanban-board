using System.Threading.Tasks;
using Application.Services.Card.Commands.CreateCard;
using Application.Services.Card.Commands.UpdateCardIndex;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace WebUI.Controllers
{
    public class CardsController : BaseController
    {
        [HttpPut("{id}/drag")]
        public async Task<ActionResult<Unit>> UpdateColumnIndex([FromBody] UpdateCardIndexCommand command)
        {
            return await Mediator.Send(command);
        }

        [HttpPost]
        public async Task<ActionResult<Unit>> CreateCard([FromBody] CreateCardCommand command)
        {
            return await Mediator.Send(command);
        }
    }
}