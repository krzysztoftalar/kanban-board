using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using Domain.Entities;

namespace Application.Dtos
{
    public class ColumnDto
    {
        public int Id { get; set; }
        public int BoardId{ get; set; }

        public string Title { get; set; }
        public int Index { get; set; }
        public IEnumerable<CardDto> Cards { get; set; }

        public static readonly Expression<Func<Column, ColumnDto>> Projection =
            column => new ColumnDto
            {
                Id = column.Id,
                BoardId = column.BoardId,
                Title = column.Title,
                Index = column.Index,
                Cards = column.Cards
                    .AsQueryable()
                    .Select(CardDto.Projection)
                    .OrderBy(y => y.Index)
            };
    }
}