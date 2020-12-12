using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using Domain.Entities;

namespace Application.Dtos
{
    public class CardDto
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public int Index { get; set; }

        public static readonly Expression<Func<Card, CardDto>> Projection =
            card => new CardDto
            {
                Id = card.Id,
                Title = card.Title,
                Index = card.Index
            };
    }
}