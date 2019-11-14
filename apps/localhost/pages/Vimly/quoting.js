module.exports = (function(options){
    "use strict";
    
    var _ = require("lodash");
    var {environments, xhr} = _.extend({
        environments: require("./environments.js"),
        xhr: require("../../js/bam/system/xhr")({lodash: _})
    }, options);

    var _headers = {
        Authorization: ""
    }

    var baseUrl = null;

    var quoting = {  
        setBaseUrl: function(url){
            baseUrl = url;
        },      
        getBaseUrl: function() {
            console.log(`quoting base url currenty set to ${baseUrl}`);
            return baseUrl;
        },
        setAuth: function(token){
            _headers.Authorization = token;
        },
        retrieve: function(type, id) {
            var urlRoot = this.getBaseUrl();
            return new Promise((resolve, reject) => {
                xhr.get(_headers, `${urlRoot}/${type}/${id}`)
                    .then(xhr => resolve(JSON.parse(xhr.responseText)))
                    .catch(reject);
            });
        }        
    }

    return _.clone(quoting);
})()