namespace Domain.Entities
{
    public class ColumnTemplate
    {
        public int Id { get; set; }
        public string Title { get; set; }
        
        public int BoardTemplateId { get; set; }
        public virtual BoardTemplate BoardTemplate { get; set; }
    }
}