using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Application.Dtos;
using Application.Helpers;
using Application.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;

namespace Application.Services.Board.Queries.GetBoards
{
    public class GetBoardsQueryHandler : IRequestHandler<GetBoardsQuery, BoardsEnvelope>
    {
        private readonly IAppDbContext _context;
        private readonly IUserAccessor _userAccessor;

        public GetBoardsQueryHandler(IAppDbContext context, IUserAccessor userAccessor)
        {
            _context = context;
            _userAccessor = userAccessor;
        }

        public async Task<BoardsEnvelope> Handle(GetBoardsQuery request, CancellationToken cancellationToken)
        {
            var queryable = _context.Users
                .Where(x => x.UserName == _userAccessor.GetCurrentUsername())
                .Include(x => x.Boards)
                .SelectMany(x => x.Boards.Select(y => new BoardDto
                {
                    Id = y.Id,
                    Title = y.Title,
                    BoardTemplateId = y.BoardTemplateId
                }));

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