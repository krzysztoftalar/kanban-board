using System.Collections.Generic;

namespace Domain.Entities
{
    public class Board
    {
        public int Id { get; set; }
        public string Title { get; set; }

        public int BoardTemplateId { get; set; }
        public virtual BoardTemplate BoardTemplate { get; set; }

        public string UserId { get; set; }
        public virtual AppUser User { get; set; }
        public virtual ICollection<Column> Columns { get; set; }
    }
}