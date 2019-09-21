let { expect } = require('chai');
let proxyHost = "gloo-test.bamapps.net";
let proxyPort = 80;
let proxyUrl = `http://${proxyHost}:${proxyPort}/serviceproxy/proxies.js`;
let glooPath = '../common/bamvvm/tvg/gloojs/gloo';
let endpointInfo = {
    host: proxyHost, 
    port: proxyPort
}
let _ = require('lodash');
let forge = require('node-forge');
let bam = require('../common/bamvvm/bam')({jQuery: {fn:{}}, lodash: _, window: {location:{protocol:'http', host: 'localhost'}}, forge: forge, dao: {}});

process.on('unhandledRejection', (reason, p) => {
    console.log('Unhandled rejection at: Promise ', p, 'reason:', reason);
})

describe("gloojs", () => {
    it("should download proxies", (done) => {        
        let gloo = require(glooPath)(bam);
        gloo.load(proxyUrl).then((proxies) => {            
            expect(proxies.GlooTestService).to.not.equal(null, "expected proxy was missing");
            expect(proxies.GlooTestService).to.not.equal(undefined, "expected proxy was missing");
            done();
        }).catch((e) => { throw e});        
    })
    it("should get proxies by url", (done) => {
        let gloo = require(glooPath)(bam);
        gloo.loadProxies(proxyUrl).then((proxies)=>{
            expect(proxies.GlooTestService).to.not.equal(null, "expected proxy was missing");
            expect(proxies.GlooTestService).to.not.equal(undefined, "expected proxy was missing");
            done();
        })
    })
    it("should get host proxies", (done) => {
        let gloo = require(glooPath)(bam);

        gloo.loadProxy(endpointInfo).then((proxies) => {
            console.log('got proxies: ' + proxies.toString());            
            for(let prop in proxies){
                console.log(prop + ': ' + proxies[prop]);
            }
            expect(proxies.GlooTestService).to.not.equal(null, "expected proxy was missing");
            expect(proxies.GlooTestService).to.not.equal(undefined, "expected proxy was missing");
            done();
        });
    })
    it("should get one host proxy", (done) => {
        let gloo = require(glooPath)(bam);

        gloo.loadProxy(endpointInfo, 'GlooTestService').then(glooTestService=>{
            expect(_.isFunction(glooTestService.getMonkey)).to.equal(true, "getTestMonkey method was not found");
            done();
        })
    })
    it("should download proxies", (done) => {
        let gloo = require(glooPath)(bam);
        
        gloo.load(proxyUrl).then((proxies)=>{            
            expect(proxies.GlooTestService).to.not.equal(null, "expected proxy was missing");
            expect(proxies.GlooTestService).to.not.equal(undefined, "expected proxy was missing");
            
            done();
        }).catch((e)=> { throw e});        
    })
})
describe("proxy", () => {
    it("should be runnable", (done) => {
        let gloo = require(glooPath)(bam),
            testName = 'some text value here';
        
        gloo.loadProxy(endpointInfo, 'GlooTestService').then(glooTestService => {
            expect(_.isFunction(glooTestService.getMonkey)).to.equal(true, "getTestMonkey method was not found");
            // test both the callback and promise implementation simultaneously
            glooTestService.getMonkey(testName, (data) =>{
                expect(data.Name).to.equal(testName);                
            }).then(data => {
                expect(data.Name).to.equal(testName);
                done();
            }).catch(e => console.log(e.toString()));            
        })
    });
    it("can get server secure channel", (done) => {
        let gloo = require(glooPath)(bam);

        gloo.loadProxy(endpointInfo, 'SecureChannel').then(secureChannel => {
            expect(_.isFunction(secureChannel.initSession)).to.equal(true);
            expect(_.isFunction(secureChannel.setSessionKey)).to.equal(true);
            done();
        })           
    });
    it("can get secure channel with its own method", done => {
        let gloo = require(glooPath)(bam);

        gloo.loadSecureChannelProxy(endpointInfo).then(secureChannel => {
            expect(_.isFunction(secureChannel.initSession)).to.equal(true);
            expect(_.isFunction(secureChannel.setSessionKey)).to.equal(true);
            done();
        })
    })
    it("should run encrypted", (done) =>{
        let gloo = require(glooPath)(bam),
            testName = 'encrypted test name';

        let callbackRan = false;
        gloo.loadProxy(endpointInfo, 'GlooEncryptedTestService').then(svc => {
            svc.getMonkey(testName, (data) => {
                expect(data.Name).to.equal('From Encrypted Test Service: ' + testName);
                callbackRan = true;
            }).then(data => {
                expect(data.Name).to.equal('From Encrypted Test Service: ' + testName);
                expect(callbackRan).to.equal(true);
                done();
            }).catch(e => console.log(e.toString())); 
        })
    })
})
