using System.Collections.Generic;
using Microsoft.AspNetCore.Identity;

namespace Domain.Entities
{
    public class AppUser : IdentityUser
    {
        public virtual ICollection<Board> Boards { get; set; }
        public virtual ICollection<RefreshToken> RefreshTokens { get; set; }
    }
}