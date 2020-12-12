using MediatR;

namespace Application.Services.Card.Commands.UpdateCardIndex
{
    public class UpdateCardIndexCommand : IRequest
    {
        public int OldCardIndex { get; set; }
        public int NewCardIndex { get; set; }
        public int OldColumnIndex { get; set; }
        public int NewColumnIndex { get; set; }
        public int CardId { get; set; }
        public int BoardId { get; set; }
    }
}