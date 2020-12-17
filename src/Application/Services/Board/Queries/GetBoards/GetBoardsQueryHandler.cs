using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Application.Dtos;
using Application.Helpers;
using Application.Interfaces;
using MediatR;

namespace Application.Services.Board.Queries.GetBoards
{
    public class GetBoardsQueryHandler : IRequestHandler<GetBoardsQuery, BoardsEnvelope>
    {
        private readonly IAppDbContext _context;

        public GetBoardsQueryHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<BoardsEnvelope> Handle(GetBoardsQuery request, CancellationToken cancellationToken)
        {
            var queryable = _context.Boards
                .Select(x => new BoardDto
                {
                    Id = x.Id,
                    Title = x.Title,
                    BoardTemplateId = x.BoardTemplateId
                })
                .AsQueryable();

            var boards = await PagedList<BoardDto>
                .CreateAsync(queryable, request.Skip, request.Limit);

            return new BoardsEnvelope
            {
                Boards = boards,
                BoardsCount = boards.TotalCount
            };
        }
    }
}