using BrpHistorie.Validatie.Interfaces;
using FluentValidation;

namespace BrpHistorie.Validatie.Validators;

public class RaadpleegMetPeildatumValidator : AbstractValidator<IRaadpleegMetPeildatumQuery>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string DatePattern = @"\d{4}-\d{2}-\d{2}";
    const string DateErrorMessage = "date||Waarde is geen geldige datum.";

    public RaadpleegMetPeildatumValidator()
    {
        RuleFor(x => x.Peildatum)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(DatePattern).WithMessage(DateErrorMessage)
            .Custom((peildatum, context) =>
            {
                if (!peildatum.IsDateTime())
                {
                    context.AddFailure(DateErrorMessage);
                }
            })
            ;
    }
}
