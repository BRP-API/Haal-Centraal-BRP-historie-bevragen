using BrpHistorie.Validatie;
using HaalCentraal.BrpHistorieStub.Entities;
using System.Linq.Expressions;

namespace HaalCentraal.BrpHistorieStub.Repositories;

public class PeriodeSpecification(string datumVan, string datumTot) : Specification<Persoon>
{
    public override Expression<Func<Persoon, bool>> ToExpression()
    {
        return persoon => persoon != null &&
                          persoon.Verblijfplaats != null &&
                          ((persoon.Verblijfplaats.DatumAanvangAdreshouding != null &&
                          datumTot.ToDateTimeOffset().ToNumber() > persoon.Verblijfplaats.DatumAanvangAdreshouding.ToNumber()) ||
                          (persoon.Verblijfplaats.DatumAanvangAdresBuitenland != null &&
                          datumTot.ToDateTimeOffset().ToNumber() > persoon.Verblijfplaats.DatumAanvangAdresBuitenland.ToNumber()))
                          &&
                          (
                           (persoon.Verblijfplaats.DatumEindeAdreshouding == null &&
                            persoon.Verblijfplaats.DatumEindeAdresBuitenland == null)
                           ||
                           (persoon.Verblijfplaats.DatumEindeAdreshouding != null &&
                            datumVan.ToDateTimeOffset().ToNumber() < persoon.Verblijfplaats.DatumEindeAdreshouding.ToNumber()
                           )
                           ||
                           (persoon.Verblijfplaats.DatumEindeAdresBuitenland != null &&
                            datumVan.ToDateTimeOffset().ToNumber() < persoon.Verblijfplaats.DatumEindeAdresBuitenland.ToNumber()
                           )
                          );
    }
}
