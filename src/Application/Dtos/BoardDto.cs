using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using Domain.Entities;

namespace Application.Dtos
{
    public class BoardDto
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public IEnumerable<ColumnDto> Columns { get; set; }

        public static readonly Expression<Func<Board, BoardDto>> Projection =
            board => new BoardDto
            {
                Id = board.Id,
                Title = board.Title,
                Columns = board.Columns
                    .AsQueryable()
                    .Select(ColumnDto.Projection)
                    .OrderBy(y => y.Index)
            };
    }
}