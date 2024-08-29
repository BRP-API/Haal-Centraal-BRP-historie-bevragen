using BrpHistorie.Infrastructure.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.DependencyInjection;
using Serilog;

namespace BrpHistorie.Infrastructure.ProblemJson;

public static class InvalidModelStateResponseFactory
{
    public static IMvcBuilder ConfigureInvalidModelStateHandling(this IMvcBuilder builder)
    {
        return builder.ConfigureApiBehaviorOptions(options =>
        {
            options.InvalidModelStateResponseFactory = context => CreateProblemDetails(context);
        });
    }

    private static IActionResult CreateProblemDetails(ActionContext context)
    {
        var invalidParams = (from kvp in context.ModelState
                             from error in kvp.Value.Errors
                             let errorCode = error.ErrorMessage.ParseErrorCode()
                             let errorReason = error.ErrorMessage.ParseErrorReason()
                             select new InvalidParams
                             {
                                 Name = $"{char.ToLowerInvariant(kvp.Key[0])}{kvp.Key[1..]}",
                                 Code = errorCode,
                                 Reason = errorReason
                             }).ToList();
        var titel = "Een of meerdere parameters zijn niet correct.";
        var code = "paramsValidation";
        var foutbericht = context.HttpContext.CreateBadRequestFoutbericht(
            titel,
            code,
            invalidParams);

        var requestBody = context.HttpContext.Request.ReadBodyAsync().Result;

        var diagnosticContext = context.HttpContext.RequestServices.GetRequiredService<IDiagnosticContext>();
        diagnosticContext.Set("request.body", requestBody);
        diagnosticContext.Set("request.headers", context.HttpContext.Request.Headers);
        diagnosticContext.Set("response.body", foutbericht, true);

        return new BadRequestObjectResult(foutbericht)
        {
            ContentTypes = { ContentTypes.ProblemJson }
        };
    }

    private static string? ParseErrorCode(this string errorMessage) =>
        errorMessage != null && errorMessage.Contains("||")
            ? errorMessage.Split("||")[0]
            : null;

    private static string? ParseErrorReason(this string errorMessage) =>
        errorMessage != null && errorMessage.Contains("||")
            ? errorMessage.Split("||")[1]
            : errorMessage;
}
