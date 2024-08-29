using BrpHistorie.Infrastructure.Logging;
using BrpHistorie.Infrastructure.ProblemJson;
using BrpHistorie.Validatie.Validators;
using FluentValidation;
using FluentValidation.AspNetCore;
using HaalCentraal.BrpHistorieStub.Repositories;
using Serilog;

Log.Logger = new LoggerConfiguration()
    .WriteTo.Console()
    .CreateLogger();

try
{
    Log.Information("Starting BRP Historie Mock");

    var builder = WebApplication.CreateBuilder(args);

    builder.Logging.ClearProviders();
    builder.Host.UseSerilog(SerilogHelpers.Configure(Log.Logger));

    // Add services to the container.

    builder.Services.AddControllers()
                    .ConfigureInvalidModelStateHandling()
                    .AddNewtonsoftJson();
    builder.Services.AddFluentValidationAutoValidation(options => options.DisableDataAnnotationsValidation = true)
                    .AddValidatorsFromAssemblyContaining<RaadpleegMetBurgerservicenummerValidator>();

    builder.Services.AddScoped<PersoonRepository>();

    builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());

    var app = builder.Build();

    // Configure the HTTP request pipeline.
    app.UseSerilogRequestLogging(options =>
    {
        options.GetLevel = CustomRequestLoggingOptions.GetLevel;
    });

    app.UseMiddleware<GlobalExceptionHandlingMiddleware>();

    app.MapControllers();

    app.Run();
}
catch (Exception ex)
{
    Log.Fatal(ex, "BRP Historie Mock terminated unexpectedly");
}
finally
{
    Log.CloseAndFlush();
}
