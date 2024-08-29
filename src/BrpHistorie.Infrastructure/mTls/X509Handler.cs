using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using System.Security.Cryptography.X509Certificates;

namespace BrpHistorie.Infrastructure.mTls;

public class X509Handler(ILogger<X509Handler> logger, IWebHostEnvironment environment, IConfiguration configuration) : DelegatingHandler
{
    protected override Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
    {
        var certificate = configuration["ClientCertificate:Name"];
        var password = configuration["ClientCertificate:Password"];

        if (!string.IsNullOrWhiteSpace(certificate) &&
            !string.IsNullOrWhiteSpace(password))
        {
            var path = Path.Combine(environment.ContentRootPath, "certificates", certificate);
            if (File.Exists(path))
            {
                var innerHandler = InnerHandler;
                while (innerHandler is DelegatingHandler handler)
                {
                    innerHandler = handler.InnerHandler;
                }
                if (innerHandler is HttpClientHandler httpClientHandler)
                {
                    try
                    {
                        var x509Certificate = new X509Certificate2(path, password);

                        httpClientHandler.ClientCertificates.Add(x509Certificate);

                        logger.LogDebug("Certificate '{path}' added for mTLS authentication", path);
                    }
                    catch (Exception ex)
                    {
                        logger.LogWarning(ex, "Unhandled exception: {ex.Message}", ex.Message);
                    }
                }
            }
            else
            {
                logger.LogWarning("Certificate file '{path}' does not exist", path);
            }
        }
        else
        {
            logger.LogDebug("No X509 certificate and/or password provided");
        }

        return base.SendAsync(request, cancellationToken);
    }
}
