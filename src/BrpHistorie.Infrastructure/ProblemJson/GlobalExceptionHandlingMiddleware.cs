using BrpHistorie.Infrastructure.Http;
using Microsoft.AspNetCore.Http;
using Newtonsoft.Json;
using Serilog;

namespace BrpHistorie.Infrastructure.ProblemJson;

public class GlobalExceptionHandlingMiddleware(RequestDelegate next, IDiagnosticContext diagnosticContext)
{
    public async Task Invoke(HttpContext context)
    {
        try
        {
            if (!context.Request.Body.CanSeek)
            {
                context.Request.EnableBuffering();
            }

            await next(context);
        }
        catch (Exception ex)
        {
            await HandleException(context, ex);
        }
    }

    private Task HandleException(HttpContext context, Exception ex)
    {
        var foutbericht = context.CreateInternalServerErrorFoutbericht();

        context.Response.StatusCode = foutbericht.Status!.Value;
        context.Response.ContentType = ContentTypes.ProblemJson;

        var requestBody = context.Request.ReadBodyAsync().Result;

        diagnosticContext.Set("request.body", requestBody);
        diagnosticContext.Set("request.headers", context.Request.Headers);
        diagnosticContext.SetException(ex);
        diagnosticContext.Set("response.body", foutbericht, true);

        return context.Response.WriteAsync(JsonConvert.SerializeObject(foutbericht, new JsonSerializerSettings
        {
            NullValueHandling = NullValueHandling.Ignore,
            DefaultValueHandling = DefaultValueHandling.Ignore
        }));
    }
}
