using System.Reflection;
using Application.Helpers;
using Application.Infrastructure;
using Application.Interfaces;
using MediatR;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.DependencyInjection;

namespace Application
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddApplication(this IServiceCollection services)
        {
            services.AddMediatR(Assembly.GetExecutingAssembly());

            return services;
        }

        public static IApplicationBuilder UseAppContext(this IApplicationBuilder app)
        {
            AppContext.Configure(app.ApplicationServices.GetRequiredService<IHttpContextAccessor>());

            return app;
        }
    }
}