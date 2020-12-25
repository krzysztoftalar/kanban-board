using System;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Application.Errors;
using Application.Helpers;
using Application.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Application.Services.Board.Commands.EditBoard
{
    public class EditBoardCommandHandler : IRequestHandler<EditBoardCommand>
    {
        private readonly IAppDbContext _context;

        public EditBoardCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<Unit> Handle(EditBoardCommand request, CancellationToken cancellationToken)
        {
            var board = await _context.Boards.FirstOrDefaultAsync(x => x.Id == request.BoardId, cancellationToken);

            if (board == null)
            {
                throw new RestException(HttpStatusCode.NotFound, new { Error = $"Not found board with id: {request.BoardId}." });
            }

            if (board.Title == request.Title)
            {
                return Unit.Value;
            }

            board.Title = request.Title;

            var success = await _context.SaveChangesAsync(cancellationToken) > 0;

            if (success) return Unit.Value;

            throw new Exception(Constants.ServerSavingError);
        }
    }
}