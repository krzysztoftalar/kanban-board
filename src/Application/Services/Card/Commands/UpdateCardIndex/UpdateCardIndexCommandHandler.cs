using System;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Application.Errors;
using Application.Extensions;
using Application.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Application.Services.Card.Commands.UpdateCardIndex
{
    public class UpdateCardIndexCommandHandler : IRequestHandler<UpdateCardIndexCommand>
    {
        private readonly IAppDbContext _context;

        public UpdateCardIndexCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<Unit> Handle(UpdateCardIndexCommand request, CancellationToken cancellationToken)
        {
            var card = await _context.Cards.FirstOrDefaultAsync(x => x.Id == request.CardId, cancellationToken);

            if (card == null)
            {
                throw new RestException(HttpStatusCode.NotFound, new { Card = "Not found card" });
            }

            if (request.OldColumnIndex != request.NewColumnIndex)
            {
                var newColumn = await _context
                    .GetColumns(x => x.Id == request.BoardId, c => c.Index == request.NewColumnIndex)
                    .FirstOrDefaultAsync(cancellationToken);

                var cardsInNewColumn = await _context
                    .GetCards(x => x.Id == request.BoardId, x => x.Index == request.NewColumnIndex,
                        c => c.Index >= request.NewCardIndex)
                    .ToListAsync(cancellationToken);

                foreach (var c in cardsInNewColumn)
                {
                    c.Index++;
                }

                var cardsInOldColumn = await _context
                    .GetCards(x => x.Id == request.BoardId, x => x.Index == request.OldColumnIndex,
                        c => c.Index > request.OldCardIndex)
                    .ToListAsync(cancellationToken);

                foreach (var c in cardsInOldColumn)
                {
                    c.Index--;
                }

                card.ColumnId = newColumn.Id;
                card.Index = request.NewCardIndex;
            }
            else if (request.OldColumnIndex == request.NewColumnIndex)
            {
                if (request.NewCardIndex > request.OldCardIndex)
                {
                    var cardsToUpdate = await _context
                        .GetCards(x => x.Id == request.BoardId, x => x.Index == request.OldColumnIndex,
                            c => c.Index <= request.NewCardIndex && c.Index > request.OldCardIndex)
                        .ToListAsync(cancellationToken);

                    foreach (var c in cardsToUpdate)
                    {
                        c.Index--;
                    }
                }
                else if (request.NewCardIndex < request.OldCardIndex)
                {
                    var cardsToUpdate = await _context
                        .GetCards(x => x.Id == request.BoardId, x => x.Index == request.OldColumnIndex,
                            c => c.Index < request.OldCardIndex && c.Index >= request.NewCardIndex)
                        .ToListAsync(cancellationToken);

                    foreach (var c in cardsToUpdate)
                    {
                        c.Index++;
                    }
                }

                card.Index = request.NewCardIndex;
            }

            var success = await _context.SaveChangesAsync(cancellationToken) > 0;

            if (success) return Unit.Value;

            throw new Exception("Problem saving changes");
        }
    }
}