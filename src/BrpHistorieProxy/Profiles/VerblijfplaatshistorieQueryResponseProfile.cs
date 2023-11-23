using AutoMapper;
using HC = HaalCentraal.BrpHistorieProxy.Generated;
using GBA = HaalCentraal.BrpHistorieProxy.Generated.Gba;

namespace BrpHistorieProxy.Profiles;

public class VerblijfplaatshistorieQueryResponseProfile : Profile
{
    public VerblijfplaatshistorieQueryResponseProfile()
    {
        CreateMap<GBA.VerblijfplaatshistorieQueryResponse, HC.VerblijfplaatshistorieQueryResponse>();
    }
}
