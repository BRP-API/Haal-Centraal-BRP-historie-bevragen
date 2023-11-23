using AutoMapper;
using HC = HaalCentraal.BrpHistorieProxy.Generated;
using GBA = HaalCentraal.BrpHistorieProxy.Generated.Gba;
using BrpHistorieProxy.Mappers;

namespace BrpHistorieProxy.Profiles;

public class VerblijfplaatsVoorkomenProfile : Profile
{
    public VerblijfplaatsVoorkomenProfile()
    {
        CreateMap<GBA.GbaVerblijfplaatsVoorkomen, HC.AbstractVerblijfplaatsVoorkomen?>().ConvertUsing<VerblijfplaatsVoorkomenConverter>();

        CreateAdresVoorkomenMapping();

        CreateLocatieVoorkomenMapping();

        CreateVerblijfplaatsBuitenlandVoorkomenMapping();

        CreateVerblijfplaatsOnbekendVoorkomenMapping();
    }

    private void CreateAdresVoorkomenMapping()
    {
        CreateMap<GBA.GbaVerblijfplaatsVoorkomen, HC.VerblijfadresBinnenland>()
            .ForMember(dest => dest.OfficieleStraatnaam, opt =>
            {
                opt.MapFrom(src => src.NaamOpenbareRuimte);
            })
            .ForMember(dest => dest.KorteStraatnaam, opt =>
            {
                opt.PreCondition(src => src.Straat != ".");
                opt.MapFrom(src => src.Straat);
            })
            .ForMember(dest => dest.Woonplaats, opt =>
            {
                opt.PreCondition(src => src.Woonplaats != ".");
                opt.MapFrom(src => src.Woonplaats);
            })
            ;

        CreateMap<GBA.GbaVerblijfplaatsVoorkomen, HC.AdresVoorkomen>()
            .ForMember(dest => dest.DatumVan, opt => opt.MapFrom(src => src.DatumAanvangAdreshouding.Map()))
            //.ForMember(dest => dest.DatumTot, opt =>
            //{
            //    opt.PreCondition(src => !string.IsNullOrWhiteSpace(src.DatumAanvangVolgendeAdreshouding) ||
            //                            !string.IsNullOrWhiteSpace(src.DatumAanvangVolgendeAdresBuitenland));
            //    opt.MapFrom(src => !string.IsNullOrWhiteSpace(src.DatumAanvangVolgendeAdreshouding)
            //                            ? src.DatumAanvangVolgendeAdreshouding.Map()
            //                            : src.DatumAanvangVolgendeAdresBuitenland.Map());
            //})
            .ForMember(dest => dest.DatumTot, opt =>
            {
                opt.PreCondition(src => src.HeeftDatumAanvangVolgendeVerblijf());
                opt.MapFrom(src => src.MapDatumTot());
            })
            .ForMember(dest => dest.Verblijfadres, opt => opt.MapFrom(src => src))
            .ForMember(dest => dest.AdresseerbaarObjectIdentificatie, opt =>
            {
                opt.PreCondition(src => src.AdresseerbaarObjectIdentificatie != "0000000000000000");
                opt.MapFrom(src => src.AdresseerbaarObjectIdentificatie);
            })
            .ForMember(dest => dest.NummeraanduidingIdentificatie, opt =>
            {
                opt.PreCondition(src => src.NummeraanduidingIdentificatie != "0000000000000000");
                opt.MapFrom(src => src.NummeraanduidingIdentificatie);
            })
            ;

            CreateMap<GBA.GbaInOnderzoek, HC.AdresVoorkomenInOnderzoek?>().ConvertUsing<AdresVoorkomenInOnderzoekConverter>();
            CreateMap<GBA.GbaInOnderzoek, HC.VerblijfadresBinnenlandInOnderzoek?>().ConvertUsing<VerblijfadresBinnenlandInOnderzoekConverter>();
    }

    private void CreateLocatieVoorkomenMapping()
    {
        CreateMap<GBA.GbaVerblijfplaatsVoorkomen, HC.VerblijfadresLocatie>();

        CreateMap<GBA.GbaVerblijfplaatsVoorkomen, HC.LocatieVoorkomen>()
            .ForMember(dest => dest.DatumVan, opt => opt.MapFrom(src => src.DatumAanvangAdreshouding.Map()))
            .ForMember(dest => dest.DatumTot, opt =>
            {
                opt.PreCondition(src => src.HeeftDatumAanvangVolgendeVerblijf());
                opt.MapFrom(src => src.MapDatumTot());
            })
            .ForMember(dest => dest.Verblijfadres, opt => opt.MapFrom(src => src))
            ;

        CreateMap<GBA.GbaInOnderzoek, HC.VerblijfadresLocatieInOnderzoek?>().ConvertUsing<VerblijfadresLocatieInOnderzoekConverter>();
        CreateMap<GBA.GbaInOnderzoek, HC.LocatieVoorkomenInOnderzoek?>().ConvertUsing<LocatieVoorkomenInOnderzoekConverter>();
    }

    private void CreateVerblijfplaatsBuitenlandVoorkomenMapping()
    {
        CreateMap<GBA.GbaVerblijfplaatsVoorkomen, HC.VerblijfadresBuitenland>()
            .ForMember(dest => dest.Land, opt =>
            {
                opt.PreCondition(src => src.Land?.Code != "0000");
            })
            ;

        CreateMap<GBA.GbaVerblijfplaatsVoorkomen, HC.VerblijfplaatsBuitenlandVoorkomen>()
            .ForMember(dest => dest.DatumVan, opt => opt.MapFrom(src => src.DatumAanvangAdresBuitenland.Map()))
            .ForMember(dest => dest.DatumTot, opt =>
            {
                opt.PreCondition(src => src.HeeftDatumAanvangVolgendeVerblijf());
                opt.MapFrom(src => src.MapDatumTot());
            })
            .ForMember(dest => dest.Verblijfadres, opt => opt.MapFrom(src => src))
            ;

        CreateMap<GBA.GbaInOnderzoek, HC.VerblijfadresBuitenlandInOnderzoek?>().ConvertUsing<VerblijfadresBuitenlandInOnderzoekConverter>();
        CreateMap<GBA.GbaInOnderzoek, HC.VerblijfplaatsBuitenlandVoorkomenInOnderzoek?>().ConvertUsing<VerblijfplaatsBuitenlandVoorkomenInOnderzoekConverter>();
    }

    private void CreateVerblijfplaatsOnbekendVoorkomenMapping()
    {
        CreateMap<GBA.GbaVerblijfplaatsVoorkomen, HC.VerblijfplaatsOnbekendVoorkomen>()
            .ForMember(dest => dest.DatumVan, opt => opt.MapFrom(src => src.MapDatumVan()))
            .ForMember(dest => dest.DatumTot, opt =>
            {
                opt.PreCondition(src => src.HeeftDatumAanvangVolgendeVerblijf());
                opt.MapFrom(src => src.MapDatumTot());
            })
            ;

        CreateMap<GBA.GbaInOnderzoek, HC.VerblijfplaatsOnbekendVoorkomenInOnderzoek?>().ConvertUsing<VerblijfplaatsOnbekendVoorkomenInOnderzoekConverter>();
    }
}
