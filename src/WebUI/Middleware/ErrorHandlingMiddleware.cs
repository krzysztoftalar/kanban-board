using System;
using System.Net;
using System.Text.Json;
using System.Threading.Tasks;
using Application.Errors;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;

namespace WebUI.Middleware
{
    public class ErrorHandlingMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<ErrorHandlingMiddleware> _logger;

        public ErrorHandlingMiddleware(RequestDelegate next, ILogger<ErrorHandlingMiddleware> logger)
        {
            _next = next;
            _logger = logger;
        }

        public async Task Invoke(HttpContext context)
        {
            try
            {
                await _next(context);
            }
            catch (Exception ex)
            {
                await HandleExceptionAsync(context, ex, _logger);
            }
        }

        private async Task HandleExceptionAsync(HttpContext context, Exception exception,
            ILogger<ErrorHandlingMiddleware> logger)
        {
            var code = HttpStatusCode.InternalServerError;
            object errors = null;

            switch (exception)
            {
                case RestException re:
                    logger.LogError(exception, "REST ERROR");
                    errors = re.Errors;
                    code = re.Code;
                    break;
                case { } e:
                    logger.LogError(exception, "SERVER ERROR");
                    errors = string.IsNullOrWhiteSpace(e.Message) ? "Error" : e.Message;
                    break;
            }

            context.Response.ContentType = "application/json";
            context.Response.StatusCode = (int) code;

            if (errors != null)
            {
                var result = JsonSerializer.Serialize(new
                {
                    errors
                });

                await context.Response.WriteAsync(result);
            }
        }
    }
}