using System.Collections.Generic;

namespace Domain.Entities
{
    public class Column
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public int Index { get; set; }

        public int BoardId { get; set; }
        public virtual Board Board { get; set; }

        public virtual ICollection<Card> Cards { get; set; }
    }
}