const { toDateOrString } = require("./calcDate");

function createObjectFrom(dataTable, dateAsDate = false) {
    let obj = {};

    
    if(dataTable.raw()[0][0] === "naam") {
        dataTable.hashes().forEach(function(row) {
            mapRowToProperty(obj, row, dateAsDate);
        });
    }
    else {
        const row = dataTable.hashes()[0];
        Object.keys(row).forEach(function(propertyName) {
            setProperty(obj, propertyName, row[propertyName], dateAsDate);
        });
    }


    return obj;
}

function createObjectArrayFrom(dataTable, dateAsDate = false) {
    let retval = [];

    dataTable.hashes().forEach(function(row) {
        let obj = {};

        Object.keys(row).forEach(function(propertyName) {
            setProperty(obj, propertyName, row[propertyName], dateAsDate);
        });

        retval.push(obj);
    });

    return retval;
}

function mapRowToProperty(obj, row, dateAsDate = false) {
    setProperty(obj, row.naam, row.waarde, dateAsDate);
}

function setProperty(obj, propertyName, propertyValue, dateAsDate) {
    if(propertyValue === undefined || propertyValue === '') {
        return;
    }

    if(propertyName.includes('.')) {
        let propertyNames = propertyName.split('.');
        let property = obj;

        propertyNames.forEach(function(propName, index) {
            if(index === propertyNames.length-1) {
                property[propName] = toDateOrString(propertyValue, dateAsDate);
            }
            else {
                if(property[propName] === undefined) {
                    property[propName] = {};
                }
                property = property[propName];
            }
        });
    }
    else {
        obj[propertyName] = toDateOrString(propertyValue, dateAsDate);
    }
}

function setObjectPropertiesFrom(obj, dataTable, dateAsDate = false) {
    if(dataTable.raw()[0][0] === 'naam') {
        dataTable.hashes().forEach(function(row) {
            mapRowToProperty(obj, row, dateAsDate);
        });
    }
    else {
        dataTable.hashes().forEach(function(row) {
            Object.keys(row).forEach(function(propertyName) {
                setProperty(obj, propertyName, row[propertyName]);
            })
        });
    }

}

module.exports = { createObjectFrom, createObjectArrayFrom, setObjectPropertiesFrom }
