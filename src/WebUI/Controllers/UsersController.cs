using System.Threading.Tasks;
using Application.Dtos;
using Application.Services.User.Commands.Logout;
using Application.Services.User.Queries.CurrentUser;
using Application.Services.User.Queries.Login;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace WebUI.Controllers
{
    public class UsersController : BaseController
    {
        [AllowAnonymous]
        [HttpPost("login")]
        public async Task<ActionResult<UserDto>> Login(LoginUserQuery query)
        {
            return await Mediator.Send(query);
        }

        [HttpGet]
        public async Task<ActionResult<UserDto>> CurrentUser()
        {
            return await Mediator.Send(new CurrentUserQuery());
        }

        [HttpPost]
        public async Task<ActionResult<Unit>> Logout()
        {
            return await Mediator.Send(new LogoutCommand());
        }
    }
}