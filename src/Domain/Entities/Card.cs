namespace Domain.Entities
{
    public class Card
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public int Index { get; set; }

        public int ColumnId { get; set; }
        public virtual Column Column { get; set; }
    }
}