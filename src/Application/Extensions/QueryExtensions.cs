using System;
using System.Linq;
using System.Linq.Expressions;
using Application.Interfaces;
using Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Application.Extensions
{
    public static class QueryExtensions
    {
        public static IQueryable<Column> GetColumns(this IAppDbContext @this,
            Expression<Func<Board, bool>> boardCriteria,
            Expression<Func<Column, bool>> colCriteria)
        {
            return @this.Boards
                .Where(boardCriteria)
                .Include(x => x.Columns)
                .SelectMany(x => x.Columns.AsQueryable().Where(colCriteria));
        }

        public static IQueryable<Card> GetCards(this IAppDbContext @this,
            Expression<Func<Board, bool>> boardCriteria,
            Expression<Func<Column, bool>> colCriteria,
            Expression<Func<Card, bool>> cardCriteria)
        {
            return @this.Boards
                .Where(boardCriteria)
                .Include(x => x.Columns)
                .ThenInclude(x => x.Cards)
                .SelectMany(x =>
                    x.Columns
                        .AsQueryable()
                        .Where(colCriteria)
                        .SelectMany(y => y.Cards
                            .AsQueryable()
                            .Where(cardCriteria)));
        }
    }
}