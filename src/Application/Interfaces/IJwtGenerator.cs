using System.Security.Claims;
using Domain.Entities;

namespace Application.Interfaces
{
    public interface IJwtGenerator
    {
        string GenerateAccessToken(AppUser user);
        RefreshToken GenerateRefreshToken(AppUser user);
        ClaimsPrincipal GetPrincipalFromExpiredToken(string token);
    }
}