using System.Reflection;

namespace BrpHistorie.Infrastructure.Logging;

public static class VersionHelpers
{
    public static string AppVersion
    {
        get
        {
            var assembly = Assembly.GetEntryAssembly();
            var version = assembly?.GetCustomAttribute<AssemblyInformationalVersionAttribute>();

            return version != null ? version.InformationalVersion : string.Empty;
        }
    }

    public static string ApiVersion
    {
        get
        {
            var assembly = Assembly.GetEntryAssembly();
            var apiVersion = assembly?.GetCustomAttribute<ApiVersionAttribute>();

            return apiVersion != null ? apiVersion.Value : string.Empty;
        }
    }
}
