using System;
using System.Threading;
using System.Threading.Tasks;
using Application.Interfaces;
using MediatR;

namespace Application.Services.Column.Commands.CreateColumnCommand
{
    public class CreateColumnCommandHandler : IRequestHandler<CreateColumnCommand>
    {
        private readonly IAppDbContext _context;

        public CreateColumnCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<Unit> Handle(CreateColumnCommand request, CancellationToken cancellationToken)
        {
            var column = new Domain.Entities.Column
            {
                BoardId = request.BoardId,
                Title = request.Title,
                Index = request.ColumnIndex
            };

            await _context.Columns.AddAsync(column, cancellationToken);

            var success = await _context.SaveChangesAsync(cancellationToken) > 0;

            if (success) return Unit.Value;

            throw new Exception("Problem saving changes");
        }
    }
}