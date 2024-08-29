using HaalCentraal.BrpHistorieStub.Entities;
using System.Linq.Expressions;

namespace HaalCentraal.BrpHistorieStub.Repositories;

public class BurgerservicenummerSpecification(string burgerservicenummer) : Specification<Persoon>
{
    public override Expression<Func<Persoon, bool>> ToExpression()
    {
        return persoon => persoon != null &&
                          !string.IsNullOrWhiteSpace(persoon.BurgerserviceNummer) &&
                          persoon.BurgerserviceNummer == burgerservicenummer;
    }
}
