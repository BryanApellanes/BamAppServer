var commands = (function(){
    var _ = require('lodash'),
        sh = require("shelljs"),
        fs = require("fs");

    return {
        readFile: function(){
            var text = fs.readFileSync('./defaultappname', "utf8");
            console.log(text);
        },
        /**
         * Build and serve the specified section of the specified application.
         * @param {*} applName 
         * @param {*} section 
         */
        serve: function(appName, section) {
            sh.exec("./test.sh");
        }
    }
})()

commands.readFile();

module.exports = commands;