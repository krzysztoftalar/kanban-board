using System.Collections.Generic;

namespace Domain.Entities
{
    public class BoardTemplate
    {
        public int Id { get; set; }
        public string Title { get; set; }

        public virtual ICollection<ColumnTemplate> ColumnTemplates { get; set; }
    }
}