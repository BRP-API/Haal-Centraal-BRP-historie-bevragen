using Microsoft.AspNetCore.Http;
using System.IO.Compression;

namespace BrpHistorie.Infrastructure.Http;

public static class HttpResponseExtensions
{
    public static bool UseGzip(this HttpResponse response) => response.Headers.ContentEncoding.Contains("gzip");

    public static async Task<string> ReadBodyAsync(this HttpResponse response)
    {
        try
        {
            if (response.UseGzip())
            {
                return await ReadCompressedBodyAsync(response);
            }
            else
            {
                return await ReadUncompressedBodyAsync(response);
            }
        }
        catch (InvalidDataException)
        {
            return await ReadUncompressedBodyAsync(response);
        }
    }

    private static async Task<string> ReadCompressedBodyAsync(this HttpResponse response)
    {
        try
        {
            response.Body.Seek(0, SeekOrigin.Begin);

            GZipStream gzipStream = new(response.Body, CompressionMode.Decompress);
            StreamReader streamReader = new(gzipStream);

            return await streamReader.ReadToEndAsync();
        }
        finally
        {
            response.Body.Seek(0, SeekOrigin.Begin);
        }
    }

    private static async Task<string> ReadUncompressedBodyAsync(this HttpResponse response)
    {
        try
        {
            response.Body.Seek(0, SeekOrigin.Begin);

            StreamReader streamReader = new(response.Body);

            return await streamReader.ReadToEndAsync();
        }
        finally
        {
            response.Body.Seek(0, SeekOrigin.Begin);
        }
    }
}
