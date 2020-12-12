using Application;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Persistence;
using WebUI.Configurations;
using WebUI.Middleware;

namespace WebUI
{
    public class Startup
    {
        public Startup(IConfiguration config)
        {
            _config = config;
        }

        private readonly IConfiguration _config;
        private const string CorsPolicy = "CorsPolicy";

        public void ConfigureServices(IServiceCollection services)
        {
            services.AddPersistence(_config);
            services.AddApplication();

            services.AddSwaggerDocumentation();

            services.AddCors(options =>
                options.AddPolicy(CorsPolicy,
                    policy =>
                    {
                        policy
                            .AllowAnyOrigin()
                            .AllowAnyMethod()
                            .AllowAnyHeader();
                    }
                ));
            
            services.AddControllers();
        }

        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }

            app.UseMiddleware<ErrorHandlingMiddleware>();
            // app.UseHttpsRedirection();

            app.UseRouting();
            app.UseCors(CorsPolicy);

            app.UseSwaggerDocumentation();

            app.UseEndpoints(endpoints => { endpoints.MapControllers(); });
        }
    }
}