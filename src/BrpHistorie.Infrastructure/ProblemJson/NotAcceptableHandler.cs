using BrpHistorie.Infrastructure.Http;
using BrpHistorie.Infrastructure.Json;
using BrpHistorie.Infrastructure.Stream;
using Microsoft.AspNetCore.Http;

namespace BrpHistorie.Infrastructure.ProblemJson;

public static class NotAcceptableHandler
{
    private static string[] _supportedAcceptValues = new[]
    {
        "*/*",
        "*/*;charset=utf-8",
        "application/json",
        "application/json;charset=utf-8"
    };

    private static Foutbericht CreateNotAcceptableFoutbericht(this HttpContext context)
    {
        return new Foutbericht
        {
            Code = "notAcceptable",
            Detail = "Ondersteunde content type: application/json; charset=utf-8.",
            Status = StatusCodes.Status406NotAcceptable,
            Instance = new Uri(context.Request.Path, UriKind.Relative),
            Title = "Gevraagde content type wordt niet ondersteund.",
            Type = new Uri(StatusCodeIdentifiers.NotAcceptableIdentifier)
        };
    }

    public static async Task<Foutbericht?> AcceptIsAllowed(this HttpContext context, System.IO.Stream orgResponseBodyStream)
    {
        foreach (var acceptValue in context.Request.Headers.Accept)
        {
            if (!string.IsNullOrWhiteSpace(acceptValue) &&
                !_supportedAcceptValues.Contains(acceptValue.ToLowerInvariant().RemoveAllWhitespace()))
            {
                var foutbericht = context.CreateNotAcceptableFoutbericht();

                using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response.UseGzip());

                context.Response.SetHeaderPropertiesFrom(foutbericht, bodyStream);

                await bodyStream.CopyToAsync(orgResponseBodyStream);

                return foutbericht;
            }
        }
        return null;
    }
}
