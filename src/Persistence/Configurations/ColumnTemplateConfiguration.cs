using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Persistence.Configurations
{
    public class ColumnTemplateConfiguration : IEntityTypeConfiguration<ColumnTemplate>
    {
        public void Configure(EntityTypeBuilder<ColumnTemplate> builder)
        {
            builder.HasKey(x => x.Id);

            builder.Property(x => x.Id)
                .IsRequired();

            builder.Property(x => x.BoardTemplateId)
                .IsRequired();

            builder.Property(x => x.Title)
                .IsRequired()
                .HasMaxLength(100);

            builder.HasOne(x => x.BoardTemplate)
                .WithMany(b => b.ColumnTemplates)
                .HasForeignKey(x => x.BoardTemplateId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}