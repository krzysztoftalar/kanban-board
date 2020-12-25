using System;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Application.Errors;
using Application.Helpers;
using Application.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Application.Services.Board.Commands.DeleteBoard
{
    public class DeleteBoardCommandHandler : IRequestHandler<DeleteBoardCommand>
    {
        private readonly IAppDbContext _context;

        public DeleteBoardCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<Unit> Handle(DeleteBoardCommand request, CancellationToken cancellationToken)
        {
            var board = await _context.Boards.FirstOrDefaultAsync(x => x.Id == request.BoardId, cancellationToken);

            if (board == null)
            {
                throw new RestException(HttpStatusCode.NotFound, new { Error = $"Not found board with id: {request.BoardId}." });
            }
            
            _context.Boards.Remove(board);

            var success = await _context.SaveChangesAsync(cancellationToken) > 0;

            if (success) return Unit.Value;

            throw new Exception(Constants.ServerSavingError);
        }
    }
}