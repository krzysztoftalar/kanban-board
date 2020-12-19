using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Application.Dtos;
using Application.Errors;
using Application.Interfaces;
using Domain.Entities;
using MediatR;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace Application.Services.User.Queries.CurrentUser
{
    public class CurrentUserQueryHandler : IRequestHandler<CurrentUserQuery, UserDto>
    {
        private readonly IJwtGenerator _jwtGenerator;
        private readonly IUserAccessor _userAccessor;
        private readonly UserManager<AppUser> _userManager;

        public CurrentUserQueryHandler(UserManager<AppUser> userManager, IJwtGenerator jwtGenerator,
            IUserAccessor userAccessor)
        {
            _userManager = userManager;
            _jwtGenerator = jwtGenerator;
            _userAccessor = userAccessor;
        }

        public async Task<UserDto> Handle(CurrentUserQuery request, CancellationToken cancellationToken)
        {
            var user = await _userManager.FindByNameAsync(_userAccessor.GetCurrentUsername());

            if (user == null)
            {
                throw new RestException(HttpStatusCode.Unauthorized, new { Error = "Unauthorized" });
            }

            return new UserDto
            {
                UserName = user.UserName,
                Token = _jwtGenerator.CreateToken(user),
            };
        }
    }
}