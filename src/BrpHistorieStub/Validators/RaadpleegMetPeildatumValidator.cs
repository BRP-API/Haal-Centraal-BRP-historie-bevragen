using FluentValidation;
using HaalCentraal.BrpHistorieStub.Generated;

namespace HaalCentraal.BrpHistorieStub.Validators;

public class RaadpleegMetPeildatumValidator : AbstractValidator<RaadpleegMetPeildatum>
{
    public RaadpleegMetPeildatumValidator()
    {
        Include(new BrpHistorie.Validatie.Validators.RaadpleegMetPeildatumValidator());
        Include(new BrpHistorie.Validatie.Validators.RaadpleegMetBurgerservicenummerValidator());
        Include(new BrpHistorie.Validatie.Validators.AdditionalPropertiesValidator());
    }
}
