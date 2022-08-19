using HaalCentraal.BrpHistorieStub.Generated;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace HaalCentraal.BrpHistorieStub.Controllers
{
    [ApiController]
    public class HistorieController : Generated.ControllerBase
    {
        private readonly ILogger<HistorieController> _logger;

        public HistorieController(ILogger<HistorieController> logger)
        {
            _logger = logger;
        }

        public override async Task<ActionResult<NationaliteithistorieQueryResponse>> Nationaliteithistorie([FromBody] HistorieQuery body)
        {
            _logger.LogDebug("Request body: {@body}", JsonConvert.SerializeObject(body));

            var retval = new NationaliteithistorieQueryResponse
            {
                Nationaliteiten = new List<GbaNationaliteit>
                {
                    new GbaNationaliteit
                    {
                        AanduidingBijzonderNederlanderschap = "B",
                        DatumIngangGeldigheid = "20220817",
                    }
                }
            };

            _logger.LogDebug("Response: {@response}", JsonConvert.SerializeObject(retval));

            return Ok(retval);
        }

        public override async Task<ActionResult<PartnerhistorieQueryResponse>> Partnerhistorie([FromBody] HistorieQuery body)
        {
            throw new NotImplementedException();
        }

        public override async Task<ActionResult<VerblijfplaatshistorieQueryResponse>> Verblijfplaatshistorie([FromBody] HistorieQuery body)
        {
            throw new NotImplementedException();
        }

        public override async Task<ActionResult<VerblijfstitelhistorieQueryResponse>> Verblijfstitelhistorie([FromBody] HistorieQuery body)
        {
            throw new NotImplementedException();
        }
    }
}
