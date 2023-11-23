using BrpHistorie.Validatie.Interfaces;
using FluentValidation;

namespace BrpHistorie.Validatie.Validators;

public class RaadpleegMetPeriodeValidator : AbstractValidator<IRaadpleegMetPeriodeQuery>
{
    const string RequiredErrorMessage = "required||Parameter is verplicht.";
    const string DatePattern = @"\d{4}-\d{2}-\d{2}";
    const string DateErrorMessage = "date||Waarde is geen geldige datum.";
    const string DateGreaterThanErrorMessage = "invalidParam||datumTot moet na datumVan liggen.";

    public RaadpleegMetPeriodeValidator()
    {
        RuleFor(x => x.DatumTot)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(DatePattern).WithMessage(DateErrorMessage)
            .Custom((datumTot, context) =>
            {
                if (!datumTot.IsDateTime())
                {
                    context.AddFailure(DateErrorMessage);
                }
            })
            ;

        RuleFor(x => x.DatumVan)
            .Cascade(CascadeMode.Stop)
            .NotEmpty().WithMessage(RequiredErrorMessage)
            .Matches(DatePattern).WithMessage(DateErrorMessage)
            .Custom((datumVan, context) =>
            {
                if (!datumVan.IsDateTime())
                {
                    context.AddFailure(DateErrorMessage);
                }
            })
            ;

        RuleFor(x => x.DatumTot!.ToDateTimeOffset())
            .GreaterThan(x => x.DatumVan!.ToDateTimeOffset()).WithMessage(DateGreaterThanErrorMessage).WithName("datumTot")
            .When(x => x.DatumTot.IsDateTime() && x.DatumVan.IsDateTime())
            ;
    }
}
