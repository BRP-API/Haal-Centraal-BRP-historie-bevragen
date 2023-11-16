class World {
    constructor(parameters) {
        this.context = parameters;
        this.context.proxyUrl = "http://localhost:5000/haalcentraal/api/brphistorie/verblijfplaatshistorie";
        this.context.apiUrl = "http://localhost:8000/haalcentraal/api/brphistorie/verblijfplaatshistorie";
        this.context.sql = {
            useDb: true,
            logStatements: false,
            cleanup: true,
            deleteIndividualRecords: true,
            poolConfig: {
                user: "root",
                host: "localhost",
                database: "rvig_haalcentraal_testdata",
                password: "root",
                port: 5432,
                allowExitOnIdle: true
            }
        };
        this.context.oAuth = {
            enable: false,
            accessTokenUrl: "https://login.dev.idsecure.nl/nidp/oauth/nam/token",
            clients:[
                {
                    afnemerID: "000008",
                    clientId: "",
                    clientSecret: "",
                    scopes: ["000000099000000080000"],
                    resourceServer: "ResourceServer02"
                }
            ]
        }
        if(this.context.parameters?.deleteIndividualRecords !== undefined) {
            this.context.sql.deleteIndividualRecords = this.context.parameters.deleteIndividualRecords;
        }
        if(this.context.parameters?.poolConfig !== undefined) {
            this.context.sql.poolConfig.host = this.context.parameters.poolConfig.host;
            this.context.sql.poolConfig.user = this.context.parameters.poolConfig.user;
            this.context.sql.poolConfig.password = this.context.parameters.poolConfig.password
        }
        if(this.context.parameters?.client !== undefined) {
            this.context.oAuth.clients[0].clientId = this.context.parameters.client.clientId; 
            this.context.oAuth.clients[0].clientSecret = this.context.parameters.client.clientSecret; 
        }
    }
}

module.exports = {World}
