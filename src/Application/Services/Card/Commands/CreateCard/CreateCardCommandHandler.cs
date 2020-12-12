using System;
using System.Threading;
using System.Threading.Tasks;
using Application.Interfaces;
using MediatR;

namespace Application.Services.Card.Commands.CreateCard
{
    public class CreateCardCommandHandler : IRequestHandler<CreateCardCommand>
    {
        private readonly IAppDbContext _context;

        public CreateCardCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<Unit> Handle(CreateCardCommand request, CancellationToken cancellationToken)
        {
            var card = new Domain.Entities.Card
            {
                ColumnId = request.ColumnId,
                Title = request.Title,
                Index = request.CardIndex
            };

            await _context.Cards.AddAsync(card, cancellationToken);

            var success = await _context.SaveChangesAsync(cancellationToken) > 0;

            if (success) return Unit.Value;

            throw new Exception("Problem saving changes");
        }
    }
}