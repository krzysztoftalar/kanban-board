﻿using System.Threading;
using System.Threading.Tasks;
using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Application.Interfaces
{
    public interface IAppDbContext
    {
        DbSet<AppUser> Users { get; set; }
        DbSet<RefreshToken> RefreshTokens { get; set; }
        
        DbSet<Board> Boards { get; set; }
        DbSet<Column> Columns { get; set; }
        DbSet<Card> Cards { get; set; }

        DbSet<BoardTemplate> BoardTemplates { get; set; }
        DbSet<ColumnTemplate> ColumnTemplates { get; set; }

        Task<int> SaveChangesAsync(CancellationToken cancellationToken = default);
    }
}