using Application.Errors;
using Domain.Entities;
using MediatR;
using Microsoft.AspNetCore.Identity;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Application.Dtos;
using Application.Interfaces;

namespace Application.Services.User.Queries.Login
{
    public class LoginUserQueryHandler : IRequestHandler<LoginUserQuery, UserDto>
    {
        private readonly IJwtGenerator _jwtGenerator;
        private readonly UserManager<AppUser> _userManager;
        private readonly SignInManager<AppUser> _signInManager;

        public LoginUserQueryHandler(UserManager<AppUser> userManager,
            SignInManager<AppUser> signInManager, IJwtGenerator jwtGenerator)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _jwtGenerator = jwtGenerator;
        }

        public async Task<UserDto> Handle(LoginUserQuery request, CancellationToken cancellationToken)
        {
            var user = await _userManager.FindByEmailAsync(request.Email);
   
            if (user == null)
            {
                throw new RestException(HttpStatusCode.Unauthorized,
                    new { Error = "Incorrect email address or password, please try again." });
            }

            if (!await _userManager.IsEmailConfirmedAsync(user))
            {
                throw new RestException(HttpStatusCode.Unauthorized,
                    new { Error = "You must have a confirmed email to log in." });
            }

            var result = await _signInManager.CheckPasswordSignInAsync(user, request.Password, false);

            if (result.Succeeded)
            {
                return new UserDto
                {
                    UserName = user.UserName,
                    Token = _jwtGenerator.CreateToken(user)
                };
            }

            throw new RestException(HttpStatusCode.Unauthorized,
                new { Error = "Incorrect email address or password, please try again." });
        }
    }
}