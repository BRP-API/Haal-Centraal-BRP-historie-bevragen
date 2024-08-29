using HaalCentraal.BrpHistorieStub.Entities;
using HaalCentraal.BrpHistorieStub.Generated;

namespace HaalCentraal.BrpHistorieStub.Repositories;

public static class PersoonQueryExtensions
{
    public static Specification<Persoon> ToSpecification(this RaadpleegMetPeriode query)
    {
        return new BurgerservicenummerSpecification(query.Burgerservicenummer!)
            .And(new PeriodeSpecification(query.DatumVan!, query.DatumTot!))
            ;
    }
}
