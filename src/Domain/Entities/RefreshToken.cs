using System;

namespace Domain.Entities
{
    public class RefreshToken
    {
        public int Id { get; set; }

        public string AppUserId { get; set; }
        public virtual AppUser AppUser { get; set; }

        public string Token { get; set; }
        public DateTime Expires { get; set; } = DateTime.UtcNow.AddDays(7);
        public DateTime? Revoked { get; set; }

        public bool IsExpired => DateTime.UtcNow >= Expires;
        public bool IsActive => Revoked == null & !IsExpired;
    }
}