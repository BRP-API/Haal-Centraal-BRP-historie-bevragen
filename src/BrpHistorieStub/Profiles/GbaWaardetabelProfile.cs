using AutoMapper;
using HaalCentraal.BrpHistorieStub.Entities;
using HaalCentraal.BrpHistorieStub.Generated;

namespace HaalCentraal.BrpHistorieStub.Profiles;

public class GbaWaardetabelProfile : Profile
{
    public GbaWaardetabelProfile()
    {
        CreateMap<Waarde, Waardetabel>();
    }
}
