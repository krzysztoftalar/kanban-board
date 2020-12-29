using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Persistence.Configurations
{
    public class BoardConfiguration : IEntityTypeConfiguration<Board>
    {
        public void Configure(EntityTypeBuilder<Board> builder)
        {
            builder.HasKey(x => x.Id);

            builder.Property(x => x.Id)
                .IsRequired();

            builder.Property(x => x.BoardTemplateId)
                .IsRequired();
            
            builder.Property(x => x.UserId)
                .IsRequired();
            
            builder.Property(x => x.Title)
                .IsRequired()
                .HasMaxLength(100);
            
            builder.HasOne(x => x.User)
                .WithMany(a => a.Boards)
                .HasForeignKey(x => x.UserId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}