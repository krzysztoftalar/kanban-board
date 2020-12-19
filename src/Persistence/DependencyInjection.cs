using Application.Interfaces;
using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Persistence
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddPersistence(this IServiceCollection services,
            IConfiguration configuration)
        {
            services.AddDbContext<AppDbContext>(options =>
            {
                options.UseSqlServer(configuration.GetConnectionString("EFKanban"));
            });

            services.AddScoped<IAppDbContext>(provider => provider.GetService<AppDbContext>());
            
            services.AddDefaultIdentity<AppUser>()
                .AddEntityFrameworkStores<AppDbContext>();

            return services;
        }
    }
}