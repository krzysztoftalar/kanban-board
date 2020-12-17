using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Application.Helpers
{
    public class PagedList<T> : List<T>
    {
        public int TotalCount { get; set; }

        public PagedList(List<T> items, int totalCount)
        {
            TotalCount = totalCount;
            AddRange(items);
        }

        public static async Task<PagedList<T>> CreateAsync(IQueryable<T> source, int? skip, int? limit)
        {
            var totalCount = await source.CountAsync();
            var items = await source
                .Skip(skip ?? 0)
                .Take(limit ?? 10)
                .ToListAsync();

            return new PagedList<T>(items, totalCount);
        }
    }
}