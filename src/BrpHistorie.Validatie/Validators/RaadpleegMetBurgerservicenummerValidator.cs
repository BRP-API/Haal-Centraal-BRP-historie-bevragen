using BrpHistorie.Validatie.Interfaces;
using FluentValidation;

namespace BrpHistorie.Validatie.Validators;

public class RaadpleegMetBurgerservicenummerValidator : AbstractValidator<IRaadpleegMetBurgerservicenummerQuery>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string BsnPattern = @"^[0-9]{9}$";
    const string BsnPatternErrorMessage = $"pattern||Waarde voldoet niet aan patroon {BsnPattern}.";

    public RaadpleegMetBurgerservicenummerValidator()
    {
        RuleFor(x => x.Burgerservicenummer)
            .Cascade(CascadeMode.Stop)
            .NotNull().WithMessage(RequiredErrorMessage)
            .Matches(BsnPattern).WithMessage(BsnPatternErrorMessage)
            ;
    }
}
