var entities = (function(){
    var baseUrl = null,
        authToken = null,
        _ = require('lodash'),
        environments = require('./environments.js'),
        xhr = require('../../js/bam/system/xhr')({lodash: _}),
        typeNameMap =  {
            "Application": "Application",
            "Case": "TaskCase",
            "Task": "TaskWorkItem"
        };    

    function getMetaProp(prop, entity) {
        if(entity[prop]) {
            return entity[prop];
        }
        if(entity[`@${prop}`]){
            return entity[`@${prop}`];
        }
    }

    function getMeta(entity) {
        return {
            id: getMetaProp("id", entity),
            type: getMetaProp("type", entity),
            schema: getMetaProp("schema", entity),
            transaction: getMetaProp("transaction", entity),
            owner: getMetaProp("owner", entity)
        }
    }

    var _headers = {
        Authorization: ""
    }

    var entities = {
        getMeta: function(entity) {
            return getMeta(entity);
        },
        setBaseUrl: function(url) {
            baseUrl = url;
        },  
        getBaseUrl: function() {
            return baseUrl;
        },
        setAuth: function(token) {
            _headers.Authorization = token;
        },
        "new": function(typeName) {
            var val = typeName;
            if(typeNameMap[typeName]){
                val = typeNameMap[typeName];
            }
            return {
                "type": val
            }
        },      
        create: function(entity) {
            // not currently implemented since most things should go through quoting for validation and authorization
        },
        retrieve: function(type, id) {
            return new Promise((resolve, reject) => {
                xhr.get(_headers, `${baseUrl}/${type}/${id}`)
                    .then((resp) => {
                        var entity = JSON.parse(resp.responseText);
                        entity.meta = getMeta(entity);
                        entity = _.extend({}, entity, entity.meta);
                        resolve(entity);
                    })
                    .catch(reject);
            });
        },
        retrieveAll: function (typeName) {
            return new Promise((resolve, reject) => {
                xhr.get(_headers, `${baseUrl}/${typeName}`)
                    .then((resp) => {
                        resolve(JSON.parse(resp.responseText));
                    })
                    .catch(reject);
            })
        },
        update: (entity) => {
            // not currently implemented since most things should go through quoting for validation and authorization
        },
        "delete": (entity) => {
            // not currently implemented since most things should go through quoting for validation and authorization
        },
        where: (predicate) => {
            // not currently implemented since most things should go through quoting for validation and authorization
        }
    }

    return _.clone(entities);
})()

module.exports = entities;