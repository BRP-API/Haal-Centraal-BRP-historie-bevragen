using Ocelot.DependencyInjection;
using Ocelot.Middleware;
using OpenTelemetry.Resources;
using OpenTelemetry.Trace;
using Serilog;
using Serilog.Enrichers.Span;
using Serilog.Exceptions;

var builder = WebApplication.CreateBuilder(args);

builder.Logging.ClearProviders();
builder.Host.UseSerilog((context, config) =>
{
    config
        .ReadFrom.Configuration(context.Configuration)
        .WriteTo.Console()
        .Enrich.WithExceptionDetails()
        .Enrich.FromLogContext()
        .Enrich.With<ActivityEnricher>()
        .WriteTo.Seq(context.Configuration["Seq:ServerUrl"]);
});

builder.Services.AddOpenTelemetryTracing(b =>
{
    b.AddConsoleExporter()
        .AddSource(builder.Environment.ApplicationName)
        .SetResourceBuilder(ResourceBuilder.CreateDefault()
                                            .AddService(builder.Environment.ApplicationName))
        .AddHttpClientInstrumentation()
        .AddAspNetCoreInstrumentation()
        .AddOtlpExporter(opts =>
        {
            opts.Endpoint = new Uri(builder.Configuration["Jaeger:OtlpEndpoint"]);
        });
});

builder.Configuration.AddJsonFile(Path.Combine("configuration", "ocelot.json"));

builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());
builder.Services.AddOcelot();

var app = builder.Build();

app.UseOcelot().Wait();

app.Run();
