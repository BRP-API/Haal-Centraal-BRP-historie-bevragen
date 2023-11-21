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

        public override async Task<ActionResult<VerblijfplaatshistorieQueryResponse>> Verblijfplaatshistorie([FromBody] HistorieQuery body)
        {
            throw new NotImplementedException();
        }
    }
}
