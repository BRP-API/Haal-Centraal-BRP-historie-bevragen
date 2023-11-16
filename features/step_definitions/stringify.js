function stringifyValues(o) {
    if(o === undefined) return o;

    Object.keys(o).forEach(k => {
        if (typeof o[k] === 'object') {
            o[k] = stringifyValues(o[k]);
        }
        else{
            o[k] = '' + o[k];
        }
    });

    return o;
}

module.exports = { stringifyValues }
