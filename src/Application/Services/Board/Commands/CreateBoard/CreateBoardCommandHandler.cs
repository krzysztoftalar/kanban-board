using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Threading;
using System.Threading.Tasks;
using Application.Dtos;
using Application.Errors;
using Application.Interfaces;
using MediatR;
using Microsoft.EntityFrameworkCore;
using BoardEntity = Domain.Entities.Board;
using ColumnEntity = Domain.Entities.Column;

namespace Application.Services.Board.Commands.CreateBoard
{
    public class CreateBoardCommandHandler : IRequestHandler<CreateBoardCommand, int>
    {
        private readonly IAppDbContext _context;

        public CreateBoardCommandHandler(IAppDbContext context)
        {
            _context = context;
        }

        public async Task<int> Handle(CreateBoardCommand request, CancellationToken cancellationToken)
        {
            BoardEntity board;

            if (request.TemplateId != 0)
            {
                var template =
                    await _context.BoardTemplates
                        .Include(x => x.ColumnTemplates)
                        .FirstOrDefaultAsync(x => x.Id == request.TemplateId, cancellationToken);

                if (template == null)
                {
                    throw new RestException(HttpStatusCode.NotFound,
                        new { BoardTemplate = "Not found board template" });
                }

                int index = 0;

                var columns = template.ColumnTemplates
                    .Select(column => new ColumnEntity { Title = column.Title, Index = index++ })
                    .ToList();

                board = new BoardEntity
                {
                    Title = request.Title,
                    BoardTemplateId = request.TemplateId,
                    Columns = columns
                };
            }
            else
            {
                board = new BoardEntity
                {
                    Title = request.Title,
                    BoardTemplateId = 1,
                    Columns = new List<ColumnEntity>()
                };
            }

            await _context.Boards.AddAsync(board, cancellationToken);

            var success = await _context.SaveChangesAsync(cancellationToken) > 0;

            if (success) return board.Id;

            throw new Exception("Problem saving changes");
        }
    }
}