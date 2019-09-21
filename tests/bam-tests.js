process.on('unhandledRejection', (reason, p) => {
    console.log('Unhandled rejection at: Promise ', p, 'reason:', reason);
})

let { expect } = require('chai');
let _ = require('lodash');
let forge = require('node-forge');
let bam = require('../common/bamvvm/bam')({jQuery: {fn:{}}, lodash: _, window: {location:{protocol:'http', host: 'localhost'}}, forge: forge, dao: {}});

describe("bam.tools", () => {
    it("should return a value", (done) => {
        let tools = bam.tools();
        expect(tools).to.not.equal('null');
        expect(tools).to.not.equal(undefined);
        done();
    })
})