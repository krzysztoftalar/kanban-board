using System.Threading.Tasks;
using Application.Services.Column.Commands.DeleteColumnCommand;
using Application.Services.Column.Commands.UpdateColumnIndex;
using Application.Services.Column.Commands.UpdateColumnTitle;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace WebUI.Controllers
{
    public class ColumnsController : BaseController
    {
        [HttpPut("{id}/drag")]
        public async Task<ActionResult<Unit>> UpdateColumnIndex([FromBody] UpdateColumnIndexCommand command)
        {
            return await Mediator.Send(command);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Unit>> UpdateColumnTitle([FromBody] UpdateColumnTitleCommand command)
        {
            return await Mediator.Send(command);
        }

        [HttpDelete("{id}")]
        public async Task<ActionResult<Unit>> DeleteColumn(int id)
        {
            return await Mediator.Send(new DeleteColumnCommand { ColumnId = id });
        }
    }
}