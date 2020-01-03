var cli = (function(){
    var templateRoot = '../../templates/',
        colors = require('colors');

    var _ = require('lodash'),
        handlebars = require('handlebars');

    var _cli = _.extend({}, {
        namedArgs: function(){
            return require("./cli-args.js");
        },
        shellExecute: function(){
            var namedArgs = _cli.namedArgs();
            var config = {                        
                    appName: namedArgs['app'],
                    type: namedArgs['type'],
                    toBeCreated: namedArgs['create'],
                    toBeRetrieved: namedArgs['retrieve'],
                    toBeUpdated: namedArgs['update'],
                    toBeDeleted: namedArgs['delete'],
                    toBeAdded: namedArgs['add']                        
                };

            var action = 'retrieve'; // a sane default
            var actionKind = 'app-host-binding'; // the only one so far
            
            if(config.toBeCreated){
                action = 'create';
                actionKind = config.toBeCreated;
            }
            if(config.toBeRetrieved){
                action = 'retrieve';
                actionKind = config.toBeRetrieved;
            }
            if(config.toBeUpdated){
                action = 'update';
                actionKind = config.toBeUpdated;
            }
            if(config.toBeDeleted){
                action = 'delete';
                actionKind = config.toBeDeleted;
            }
            if(config.toBeAdded){
                action = 'add';
                actionKind = config.toBeAdded;
            }
            cli.execute(action, actionKind);            
        },
        execute: function(actionName, actionKind){
            console.log(`action: ${actionName}, kind: ${actionKind}`.cyan);
            var module = require(`./${actionName}/${actionKind}`);
            module[actionName]();
        }
    });
    return _cli;
})()

module.exports = cli;

if(process.argv[2] === "shellExecute"){
    cli.shellExecute();
}