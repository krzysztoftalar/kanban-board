using MediatR;

namespace Application.Services.Card.Commands.CreateCard
{
    public class CreateCardCommand : IRequest
    {
        public int ColumnId { get; set; }
        public int CardIndex { get; set; }
        public string Title { get; set; }
    }
}