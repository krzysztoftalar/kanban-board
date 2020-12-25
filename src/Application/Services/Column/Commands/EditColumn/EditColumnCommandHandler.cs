using System;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Application.Errors;
using Application.Helpers;
using Application.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Application.Services.Column.Commands.EditColumn
{
    public class EditColumnCommandHandler : IRequestHandler<EditColumnCommand>
    {
        private readonly IAppDbContext _context;

        public EditColumnCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<Unit> Handle(EditColumnCommand request, CancellationToken cancellationToken)
        {
            var column = await _context.Columns.FirstOrDefaultAsync(x => x.Id == request.ColumnId, cancellationToken);

            if (column == null)
            {
                throw new RestException(HttpStatusCode.NotFound, new { Error = $"Not found column with id: {request.ColumnId}." });
            }

            if (column.Title == request.Title)
            {
                return Unit.Value;
            }

            column.Title = request.Title;

            var success = await _context.SaveChangesAsync(cancellationToken) > 0;

            if (success) return Unit.Value;

            throw new Exception(Constants.ServerSavingError);
        }
    }
}