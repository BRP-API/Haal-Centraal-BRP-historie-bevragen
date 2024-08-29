using Microsoft.AspNetCore.Http;
using Serilog.Events;

namespace BrpHistorie.Infrastructure.Logging;

public static class CustomRequestLoggingOptions
{
    public static LogEventLevel GetLevel(HttpContext httpContext, double _, Exception? ex) =>
        ex != null
            ? LogEventLevel.Error
            : httpContext.Response switch
            {
                { StatusCode: var status } when status >= 500 => LogEventLevel.Error,
                { StatusCode: var status } when status >= 400 && status < 500 => LogEventLevel.Warning,
                _ => LogEventLevel.Information
            };
}
