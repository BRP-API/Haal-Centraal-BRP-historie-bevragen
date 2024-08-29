using FluentValidation;
using Newtonsoft.Json.Linq;

namespace BrpHistorieProxy.Validators;

public class HistorieQueryRequestBodyValidator : AbstractValidator<JObject>
{
    const string RequiredErrorMessage = "type||required||Parameter is verplicht.";
    const string TypePattern = @"^RaadpleegMetPeildatum|RaadpleegMetPeriode$";
    const string TypePatternErrorMessage = "type||value||Waarde is geen geldig zoek type.";

    public HistorieQueryRequestBodyValidator()
    {
        RuleFor(x => x.Value<string>("type"))
            .Cascade(CascadeMode.Stop)
            .NotNull().WithMessage(RequiredErrorMessage)
            .Matches(TypePattern).WithMessage(TypePatternErrorMessage);
    }
}
