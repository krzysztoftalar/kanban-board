using System;
using System.Linq;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Application.Errors;
using Application.Extensions;
using Application.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Application.Services.Column.Commands.UpdateColumnIndex
{
    public class UpdateColumnIndexCommandHandler : IRequestHandler<UpdateColumnIndexCommand>
    {
        private readonly IAppDbContext _context;

        public UpdateColumnIndexCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<Unit> Handle(UpdateColumnIndexCommand request, CancellationToken cancellationToken)
        {
            var column = await _context.Columns.FirstOrDefaultAsync(x => x.Id == request.ColumnId, cancellationToken);

            if (column == null)
            {
                throw new RestException(HttpStatusCode.NotFound, new { Column = "Not found column" });
            }

            if (request.NewIndex > request.OldIndex)
            {
                var columnsToUpdate = await _context
                    .GetColumns(b => b.Id == request.BoardId,
                        c => c.Index <= request.NewIndex && c.Index > request.OldIndex)
                    .ToListAsync(cancellationToken);

                foreach (var col in columnsToUpdate)
                {
                    col.Index--;
                }
            }
            else if (request.NewIndex < request.OldIndex)
            {
                var columnsToUpdate = await _context
                    .GetColumns(b => b.Id == request.BoardId,
                        c => c.Index < request.OldIndex && c.Index >= request.NewIndex)
                    .ToListAsync(cancellationToken);

                foreach (var col in columnsToUpdate)
                {
                    col.Index++;
                }
            }

            column.Index = request.NewIndex;

            var success = await _context.SaveChangesAsync(cancellationToken) > 0;

            if (success) return Unit.Value;

            throw new Exception("Problem saving changes");
        }
    }
}