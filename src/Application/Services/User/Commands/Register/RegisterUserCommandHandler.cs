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
        private readonly ICookieService _cookieService;
        private readonly UserManager<AppUser> _userManager;

        public RegisterUserCommandHandler(IAppDbContext context, IJwtGenerator jwtGenerator,
            UserManager<AppUser> userManager, ICookieService cookieService)
        {
            _context = context;
            _jwtGenerator = jwtGenerator;
            _userManager = userManager;
            _cookieService = cookieService;
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
                var refreshToken = _jwtGenerator.GenerateRefreshToken(user);
                
                await _context.RefreshTokens.AddAsync(refreshToken, cancellationToken);
            
                var success = await _context.SaveChangesAsync(cancellationToken) > 0;

                if (success)
                {
                    _cookieService.SetCookieToken(refreshToken.Token);

                    return new UserDto
                    {
                        UserName = user.UserName,
                        Token = _jwtGenerator.CreateToken(user)
                    };
                }
            }

            throw new Exception("Problem creating user.");
        }
    }
}