using System;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Application.Errors;
using Application.Extensions;
using Application.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Application.Services.Column.Commands.DeleteColumnCommand
{
    public class DeleteColumnCommandHandler : IRequestHandler<DeleteColumnCommand>
    {
        private readonly IAppDbContext _context;

        public DeleteColumnCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<Unit> Handle(DeleteColumnCommand request, CancellationToken cancellationToken)
        {
            var column = await _context.Columns.FirstOrDefaultAsync(x => x.Id == request.ColumnId, cancellationToken);

            if (column == null)
            {
                throw new RestException(HttpStatusCode.NotFound, new { Column = "Not found column" });
            }

            var columnsToUpdate = await _context
                .GetColumns(b => b.Id == column.BoardId, c => c.Index > column.Index)
                .ToListAsync(cancellationToken);

            foreach (var col in columnsToUpdate)
            {
                col.Index--;
            }

            _context.Columns.Remove(column);

            var success = await _context.SaveChangesAsync(cancellationToken) > 0;

            if (success) return Unit.Value;

            throw new Exception("Problem saving changes");
        }
    }
}