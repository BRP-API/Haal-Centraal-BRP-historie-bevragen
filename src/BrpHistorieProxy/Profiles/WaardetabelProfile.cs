using AutoMapper;
using HC = HaalCentraal.BrpHistorieProxy.Generated;
using GBA = HaalCentraal.BrpHistorieProxy.Generated.Gba;

namespace BrpHistorieProxy.Profiles;

public class WaardetabelProfile : Profile
{
    public WaardetabelProfile()
    {
        CreateMap<GBA.Waardetabel, HC.Waardetabel>();
    }
}
