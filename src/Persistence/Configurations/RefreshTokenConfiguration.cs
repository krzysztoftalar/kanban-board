using System;
using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Persistence.Configurations
{
    public class RefreshTokenConfiguration : IEntityTypeConfiguration<RefreshToken>
    {
        public void Configure(EntityTypeBuilder<RefreshToken> builder)
        {
            builder.HasKey(x => x.Id);

            builder.Property(x => x.Id)
                .IsRequired();

            builder.Property(x => x.AppUserId)
                .IsRequired();

            builder.Property(x => x.Token)
                .IsRequired();

            builder.Property(x => x.Expires)
                .IsRequired()
                .HasDefaultValue(DateTime.UtcNow.AddDays(7));

            builder.Property(x => x.Revoked)
                .IsRequired(false);
            
            builder.HasOne(x => x.AppUser)
                .WithMany(a => a.RefreshTokens)
                .HasForeignKey(x => x.AppUserId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}