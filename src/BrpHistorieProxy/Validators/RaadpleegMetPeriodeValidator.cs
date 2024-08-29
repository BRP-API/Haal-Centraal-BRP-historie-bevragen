using FluentValidation;
using HaalCentraal.BrpHistorieProxy.Generated;

namespace BrpHistorieProxy.Validators;

public class RaadpleegMetPeriodeValidator : AbstractValidator<RaadpleegMetPeriode>
{
    public RaadpleegMetPeriodeValidator()
    {
        Include(new BrpHistorie.Validatie.Validators.RaadpleegMetBurgerservicenummerValidator());
        Include(new BrpHistorie.Validatie.Validators.RaadpleegMetPeriodeValidator());
        Include(new BrpHistorie.Validatie.Validators.AdditionalPropertiesValidator());
    }
}
