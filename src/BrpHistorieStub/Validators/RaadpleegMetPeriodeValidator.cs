using FluentValidation;
using HaalCentraal.BrpHistorieStub.Generated;

namespace HaalCentraal.BrpHistorieStub.Validators;

public class RaadpleegMetPeriodeValidator : AbstractValidator<RaadpleegMetPeriode>
{
    public RaadpleegMetPeriodeValidator()
    {
        Include(new BrpHistorie.Validatie.Validators.RaadpleegMetPeriodeValidator());
        Include(new BrpHistorie.Validatie.Validators.RaadpleegMetBurgerservicenummerValidator());
        Include(new BrpHistorie.Validatie.Validators.AdditionalPropertiesValidator());
    }
}
