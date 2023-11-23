using AutoMapper;
using BrpHistorie.Validatie;
using HaalCentraal.BrpHistorieStub.Entities;
using HaalCentraal.BrpHistorieStub.Generated;
using HaalCentraal.BrpHistorieStub.Repositories;
using Microsoft.AspNetCore.Mvc;
using Serilog;

namespace HaalCentraal.BrpHistorieStub.Controllers;

[ApiController]
public class HistorieController(IDiagnosticContext diagnosticContext, PersoonRepository repository, IMapper mapper) : Generated.ControllerBase
{
    public override async Task<ActionResult<VerblijfplaatshistorieQueryResponse>> Verblijfplaatshistorie([FromBody] HistorieQuery body)
    {
        diagnosticContext.Set("request.body", body, true);
        diagnosticContext.Set("request.headers", HttpContext.Request.Headers);

        var retval = body switch
        {
            RaadpleegMetPeildatum q => await Handle(q),
            RaadpleegMetPeriode q => await Handle(q),
            _ => new VerblijfplaatshistorieQueryResponse()
        };

        diagnosticContext.Set("response.body", retval, true);

        return Ok(retval);
    }

    private async Task<VerblijfplaatshistorieQueryResponse> Handle(RaadpleegMetPeildatum q)
    {
        RaadpleegMetPeriode filter = new()
        {
            Burgerservicenummer = q.Burgerservicenummer,
            ExclusiefVerblijfplaatsBuitenland = q.ExclusiefVerblijfplaatsBuitenland,
            DatumVan = q.Peildatum,
            DatumTot = q.Peildatum!.ToDateTimeOffset().AddDays(1).ToString("yyyy-MM-dd"),
        };
        var personen = await repository.Zoek<RaadpleegMetPeriode>(filter);

        return new VerblijfplaatshistorieQueryResponse
        {
            Verblijfplaatsen = personen.ToVerblijfplaatsVoorkomens(mapper)
        };
    }

    private async Task<VerblijfplaatshistorieQueryResponse> Handle(RaadpleegMetPeriode q)
    {
        var personen = await repository.Zoek<RaadpleegMetPeriode>(q);


        return new VerblijfplaatshistorieQueryResponse
        {
            Verblijfplaatsen = personen.ToVerblijfplaatsVoorkomens(mapper)
        };
    }
}

public static class VerblijfplaatsVoorkomenMappers
{
    public static List<GbaVerblijfplaatsVoorkomen> ToVerblijfplaatsVoorkomens(this ICollection<Persoon>? personen, IMapper mapper)
    {
        var retval = new List<GbaVerblijfplaatsVoorkomen>();

        if(personen == null) return retval;

        foreach (var persoon in personen)
        {
            var verblijfplaats = persoon?.Verblijfplaats;
            if (verblijfplaats != null)
            {
                retval.Add(mapper.Map<GbaVerblijfplaatsVoorkomen> (verblijfplaats));
            }
        }

        return retval;
    }
}
