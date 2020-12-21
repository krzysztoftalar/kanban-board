using Application.Errors;
using Application.Interfaces;
using Domain.Entities;
using MediatR;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Application.Dtos;

namespace Application.Services.User.Commands.Register
{
    public class RegisterUserCommandHandler : IRequestHandler<RegisterUserCommand, UserDto>
    {
        private readonly IAppDbContext _context;
        private readonly IJwtGenerator _jwtGenerator;
        private readonly UserManager<AppUser> _userManager;

        public RegisterUserCommandHandler(IAppDbContext context, IJwtGenerator jwtGenerator,
            UserManager<AppUser> userManager)
        {
            _context = context;
            _jwtGenerator = jwtGenerator;
            _userManager = userManager;
        }

        public async Task<UserDto> Handle(RegisterUserCommand request, CancellationToken cancellationToken)
        {
            if (await _context.Users.AnyAsync(x => x.Email == request.Email, cancellationToken))
            {
                throw new RestException(HttpStatusCode.BadRequest, new { Error = "Email already exists." });
            }

            if (await _context.Users.AnyAsync(x => x.UserName == request.UserName, cancellationToken))
            {
                throw new RestException(HttpStatusCode.BadRequest, new { Error = "Username already exists." });
            }

            var user = new AppUser
            {
                UserName = request.UserName,
                Email = request.Email
            };

            var result = await _userManager.CreateAsync(user, request.Password);

            if (result.Succeeded)
            {
                return new UserDto
                {
                    UserName = user.UserName,
                    Token = _jwtGenerator.CreateToken(user)
                };
            }

            throw new Exception("Problem creating user");
        }
    }
}