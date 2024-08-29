using BrpHistorie.Infrastructure.Http;
using BrpHistorie.Infrastructure.Json;
using BrpHistorie.Infrastructure.Stream;
using Microsoft.AspNetCore.Http;

namespace BrpHistorie.Infrastructure.ProblemJson;

public static class UnsupportedMediaTypeHandler
{
    private static Foutbericht CreateUnsupportedMediaTypeFoutbericht(this HttpContext context)
    {
        return new Foutbericht
        {
            Code = "unsupportedMediaType",
            Detail = "Ondersteunde content type: application/json; charset=utf-8.",
            Status = StatusCodes.Status415UnsupportedMediaType,
            Instance = new Uri(context.Request.Path, UriKind.Relative),
            Title = "Media Type wordt niet ondersteund.",
            Type = new Uri(StatusCodeIdentifiers.UnsupportedMediaTypeIdentifier)
        };
    }

    public static async Task<Foutbericht?> ContentTypeIsAllowed(this HttpContext context, System.IO.Stream orgResponseBodyStream)
    {
        foreach (var contentType in context.Request.Headers.ContentType)
        {
            if (!string.IsNullOrWhiteSpace(contentType) &&
                !new[]
                {
                    "application/json",
                    "application/json;charset=utf-8"
                }.Contains(contentType.ToLowerInvariant().RemoveAllWhitespace()))
            {
                var foutbericht = context.CreateUnsupportedMediaTypeFoutbericht();

                using var bodyStream = foutbericht.ToJson().ToMemoryStream(context.Response.UseGzip());

                context.Response.SetHeaderPropertiesFrom(foutbericht, bodyStream);

                await bodyStream.CopyToAsync(orgResponseBodyStream);

                return foutbericht;
            }
        }
        return null;
    }
}
