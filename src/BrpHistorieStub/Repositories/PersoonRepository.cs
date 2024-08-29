using HaalCentraal.BrpHistorieStub.Entities;
using HaalCentraal.BrpHistorieStub.Generated;
using Newtonsoft.Json;

namespace HaalCentraal.BrpHistorieStub.Repositories;

public class PersoonRepository(IWebHostEnvironment environment)
{
    public async Task<ICollection<Persoon>?> Zoek<T>(T query)
    {
        var path = Path.Combine(environment.ContentRootPath, "Data", "test-data.json");
        if (!File.Exists(path))
        {
            throw new FileNotFoundException($"invalid file: '{path}'");
        }

        var data = await File.ReadAllTextAsync(path);

        return query switch
        {
            RaadpleegMetPeriode f => JsonConvert.DeserializeObject<List<Persoon>>(data)?
                .AsQueryable().Where(f.ToSpecification().ToExpression()).ToList(),
            _ => throw new NotSupportedException($"{query}")
        };
    }
}
