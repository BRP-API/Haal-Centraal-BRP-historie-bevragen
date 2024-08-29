using AutoMapper;
using BrpHistorie.Infrastructure.Http;
using BrpHistorie.Infrastructure.ProblemJson;
using BrpHistorie.Infrastructure.Stream;
using BrpHistorieProxy.Helpers;
using BrpHistorieProxy.Validators;
using HaalCentraal.BrpHistorieProxy.Generated;
using Newtonsoft.Json;
using Serilog;

namespace BrpHistorieProxy.Middlewares;

public class OverwriteResponseBodyMiddleware(RequestDelegate next, ILogger<OverwriteResponseBodyMiddleware> logger, IMapper mapper, IDiagnosticContext diagnosticContext)
{
    private async Task<bool> RequestIsValid(HttpContext context, string requestBody, Stream orgBodyStream)
    {
        var problemJson = await context.MethodIsAllowed(orgBodyStream);
        if (problemJson != null)
        {
            diagnosticContext.Set("response.body", problemJson, true);

            return false;
        }
        problemJson = await context.AcceptIsAllowed(orgBodyStream);
        if (problemJson != null)
        {
            diagnosticContext.Set("response.body", problemJson, true);

            return false;
        }
        problemJson = await context.ContentTypeIsAllowed(orgBodyStream);
        if (problemJson != null)
        {
            diagnosticContext.Set("response.body", problemJson, true);

            return false;
        }

        HistorieQuery? historieQuery;
        try
        {
            historieQuery = JsonConvert.DeserializeObject<HistorieQuery>(requestBody);
        }
        catch (JsonSerializationException ex)
        {
            problemJson = await context.HandleJsonDeserializeException(ex, orgBodyStream);
            diagnosticContext.SetException(ex);
            diagnosticContext.Set("response.body", problemJson, true);

            return false;
        }
        catch (JsonReaderException ex)
        {
            problemJson = await context.HandleJsonDeserializeException(ex, orgBodyStream);
            diagnosticContext.SetException(ex);
            diagnosticContext.Set("response.body", problemJson, true);

            return false;
        }

        var validationResult = historieQuery.Validate(requestBody);
        if (!validationResult.IsValid)
        {
            problemJson = await context.HandleValidationErrors(validationResult, orgBodyStream);
            diagnosticContext.Set("response.body", problemJson, true);

            return false;
        }

        return true;
    }

    public async Task Invoke(HttpContext context)
    {
        logger.LogDebug("TimeZone: {@localTimeZone}. Now: {@now}", TimeZoneInfo.Local.StandardName, DateTime.Now);

        var orgBodyStream = context.Response.Body;

        try
        {
            var requestBody = await context.Request.ReadBodyAsync();
            diagnosticContext.Set("request.body", requestBody);
            diagnosticContext.Set("request.headers", context.Request.Headers);

            if (!await RequestIsValid(context, requestBody, orgBodyStream))
            {
                return;
            }

            using var newBodyStream = new MemoryStream();
            context.Response.Body = newBodyStream;

            await next(context);

            var body = await context.Response.ReadBodyAsync();

            diagnosticContext.Set("api response.body", body);

            var modifiedBody = context.Response.StatusCode == StatusCodes.Status200OK
                ? body.Transform(mapper)
                : body;

            diagnosticContext.Set("response.body", modifiedBody);

            using var bodyStream = modifiedBody.ToMemoryStream(context.Response.UseGzip());

            context.Response.ContentLength = bodyStream.Length;
            await bodyStream.CopyToAsync(orgBodyStream);
        }
        catch (Exception ex)
        {
            var problemJson = await context.HandleUnhandledException(orgBodyStream);
            diagnosticContext.SetException(ex);
            diagnosticContext.Set("response.body", problemJson, true);
        }
    }
}
