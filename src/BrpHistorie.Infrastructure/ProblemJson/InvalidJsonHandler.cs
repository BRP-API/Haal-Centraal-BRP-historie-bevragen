using BrpHistorie.Infrastructure.Http;
using BrpHistorie.Infrastructure.Json;
using BrpHistorie.Infrastructure.Stream;
using Microsoft.AspNetCore.Http;
using System.Text.RegularExpressions;

namespace BrpHistorie.Infrastructure.ProblemJson;

public static class InvalidJsonHandler
{
    private static readonly Regex UnexpectedCharacterEncounteredRegex = new(@"an unexpected character was encountered: (.*). Path '(?<name>.*)'");
    private static readonly Regex ErrorConvertingToTypeRegex = new(@"Error converting value ""(.*)""(.*). Path '(?<name>.*)'");
    private static readonly Regex NotValidClosingForArrayRegex = new(@"not valid for closing JsonType Array. Path '(?<name>.*)'");
    private static readonly Regex UnexpectedTokenStartArrayRegex = new(@"Error reading string. Unexpected token: StartArray.");

    private static (string name, string code, string reason) Parse(this Exception ex)
    {
        var match = UnexpectedCharacterEncounteredRegex.Match(ex.Message);
        if (match.Success)
        {
            return (match.Groups["name"].Value, string.Empty, "waarde is niet valide");
        }
        match = ErrorConvertingToTypeRegex.Match(ex.Message);
        if (match.Success)
        {
            return (match.Groups["name"].Value, string.Empty, "Parameter is geen array");
        }
        match = NotValidClosingForArrayRegex.Match(ex.Message);
        if (match.Success)
        {
            return (match.Groups["name"].Value, string.Empty, "Parameter is geen array");
        }
        match = UnexpectedTokenStartArrayRegex.Match(ex.Message);
        if (match.Success)
        {
            return ("type", "required", "Parameter is verplicht.");
        }

        return (string.Empty, string.Empty, string.Empty);
    }

    public static async Task<Foutbericht> HandleJsonDeserializeException(this HttpContext context, Exception ex, System.IO.Stream orgResponseBodyStream)
    {
        (string name, string code, string reason) = ex.Parse();
        List<InvalidParams> invalidParams = new();
        if (!string.IsNullOrEmpty(name) ||
            !string.IsNullOrEmpty(code) ||
            !string.IsNullOrEmpty(reason))
        {
            invalidParams.Add(new InvalidParams { Name = name, Code = code, Reason = reason });
        }

        var message = new BadRequestFoutbericht
        {
            Instance = new Uri(context.Request.Path, UriKind.Relative),
            Status = StatusCodes.Status400BadRequest,
            Title = "Een of meerdere parameters zijn niet correct.",
            Type = new Uri(StatusCodeIdentifiers.BadRequestIdentifier),
            Code = "paramsValidation",
            Detail = $"De foutieve parameter(s) zijn: {name}.",
            InvalidParams = invalidParams
        };

        using var bodyStream = message.ToJson().ToMemoryStream(context.Response.UseGzip());

        context.Response.SetHeaderPropertiesFrom(message, bodyStream);

        await bodyStream.CopyToAsync(orgResponseBodyStream);

        return message;
    }
}
