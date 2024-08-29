using FluentValidation;
using HaalCentraal.BrpHistorieProxy.Generated;

namespace BrpHistorieProxy.Validators;

public class RaadpleegMetPeildatumValidator : AbstractValidator<RaadpleegMetPeildatum>
{
    public RaadpleegMetPeildatumValidator()
    {
        Include(new BrpHistorie.Validatie.Validators.RaadpleegMetBurgerservicenummerValidator());
        Include(new BrpHistorie.Validatie.Validators.RaadpleegMetPeildatumValidator());
        Include(new BrpHistorie.Validatie.Validators.AdditionalPropertiesValidator());
    }
}
