using System;
using System.Linq;
using System.Linq.Expressions;
using Microsoft.EntityFrameworkCore;

namespace Application.Extensions
{
    public static class GenericQueryExtensions
    {
        public static IQueryable<TResult> Get<TResult>(this DbSet<TResult> @this,
            Expression<Func<TResult, bool>> criteria) where TResult : class
        {
            return @this.Where(criteria);
        }
    }
}