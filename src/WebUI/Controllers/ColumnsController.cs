using System.Threading.Tasks;
using Application.Services.Column.Commands.CreateColumnCommand;
using Application.Services.Column.Commands.DeleteColumnCommand;
using Application.Services.Column.Commands.EditColumn;
using Application.Services.Column.Commands.UpdateColumnIndex;
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

        [HttpPost]
        public async Task<ActionResult<Unit>> CreateColumn([FromBody] CreateColumnCommand command)
        {
            return await Mediator.Send(command);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Unit>> EditColumn([FromBody] EditColumnCommand command)
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