using System.Linq;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Application.Dtos;
using Application.Errors;
using Application.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Application.Services.Board.Queries.GetBoard
{
    public class GetBoardQueryHandler : IRequestHandler<GetBoardQuery, BoardDto>
    {
        private readonly IAppDbContext _context;

        public GetBoardQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<BoardDto> Handle(GetBoardQuery request, CancellationToken cancellationToken)
        {
            var board = await _context.Boards
                .Include(x => x.Columns)
                .ThenInclude(x => x.Cards)
                .Where(x => x.Id == request.Id)
                .Select(BoardDto.Projection)
                .FirstOrDefaultAsync(cancellationToken);

            if (board == null)
            {
                throw new RestException(HttpStatusCode.NotFound, new { Error = "Not found board" });
            }

            return board;
        }
    }
}