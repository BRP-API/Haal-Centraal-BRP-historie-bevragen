using AutoMapper;
using HaalCentraal.BrpHistorieStub.Entities;
using HaalCentraal.BrpHistorieStub.Generated;

namespace HaalCentraal.BrpHistorieStub.Profiles;

public class GbaVerblijfplaatsVoorkomenProfile : Profile
{
    public GbaVerblijfplaatsVoorkomenProfile()
    {
        CreateMap<Verblijfplaats, GbaVerblijfplaatsVoorkomen>()
            .ForMember(dest => dest.DatumAanvangVolgendeAdreshouding, opt => opt.MapFrom(src => src.DatumEindeAdreshouding))
            .ForMember(dest => dest.DatumAanvangVolgendeAdresBuitenland, opt => opt.MapFrom(src => src.DatumEindeAdresBuitenland));
    }
}
