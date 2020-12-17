using Application.Dtos;
using MediatR;

namespace Application.Services.Board.Commands.CreateBoard
{
    public class CreateBoardCommand : IRequest<int>
    {
        public string Title { get; set; }
        public int TemplateId { get; set; }
    }
}