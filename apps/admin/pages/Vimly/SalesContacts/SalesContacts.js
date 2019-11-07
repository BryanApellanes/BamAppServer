$(document).ready(function(){
    var _ = require("lodash"),
        envs = require('../environments.js'),
        dataTableTools = require('../../../js/bam/ui/dataTableTools.js'),
        handlebars = require("handlebars"),
        entities = require("../entities.js")
        quoting = require("../quoting.js");
    
    function getAuthHeader(){
        var selectedEnv = $("#vimlyEnv option:selected").text(); 
        envs.setCurrent(selectedEnv);
        return envs.getAuthorizationHeader(selectedEnv);        
    }

    function setEnvironment(){
        var selectedEnv = $("#vimlyEnvironment option:selected").text(); 
        envs.setCurrent(selectedEnv);
        entities.setBaseUrl(envs.getEntityPath());
        quoting.setBaseUrl(envs.getQuotingPath());
    }

    function getEntityType(){
        return $("select[name=entityType]").val();
    }

    function getEntityId(){
        return $("input[name=entityId]").val();
    }

    function getPlanSponsorId(){
        return $("input[name=planSponsorId]").val();
    }

    function getApplicationId(){
        return $("input[name=applicationId]").val();
    }

    function getQuotingApplicationId(){
        return $("input[name=quotingApplicationId]").val();
    }

    function getQuotingPlanSponsorId(){
        return $("input[name=quotingPlanSponsorId]").val();
    }

    function toNameValuePairs(obj){
        var results = [];
        for(var prop in obj){
            results.push({name: prop, value: obj[prop]});
        }
        return results;
    }

    function getPlanSponsorModel(planSponsorEntity) {
        return {
            businessName: planSponsorEntity.businessName.legalName,
            contacts: getContactsModel(planSponsorEntity.contacts || [])
        }
    }

    function getApplicationModel(applicationEntity){
        return {
            friendlyId: applicationEntity.friendlyId
        }
    }

    function getContactsModel(contacts){
        return _.map(contacts, function(ctc){
            return {
                firstName: ctc.firstName,
                lastName: ctc.lastName,
                contactTypes: (ctc.contactTypes || []).join(', '),
                communications: _.map((ctc.communications || []), function(method) {
                    return `${method.communicationLocation}: ${method.fax || method.email || method.phone || ""}`;
                })
            }
        });
    }

    function setContactsDisplay(contacts){
        var contactsModel = getContactsModel(contacts),
            contactsHtml = '';

        _.each(contactsModel, function(contactModel){
            contactsHtml += salesContactsPage.template("contactDisplay", contactModel);
        })
        $("#contactsDisplay").html(contactsHtml);
    }

    function displayEntity(entity){    
        var entityHtml = salesContactsPage.template("entityInput", {properties: toNameValuePairs(entity)});
        $("#entityDisplay").html(entityHtml);
    }

    function displayApplication(application) {
        var applicationModel = getApplicationModel(application);
        var applicationHtml = salesContactsPage.template("applicationDisplay", applicationModel);

        $("#entityApplicationDisplay").html(applicationHtml);
    }

    function displayPlanSponsor(planSponsor) {
        var planSponsorModel = getPlanSponsorModel(planSponsor);
        var planSponsorHtml = salesContactsPage.template("planSponsorDisplay", planSponsorModel);

        $("#entityPlanSponsorDisplay").html(planSponsorHtml);
    }

    function reset(){
        $("#contactsDisplay").html('');
        $("#entityDisplay").html('');
        $("#entityApplicationDisplay").html('');
        $("#entityPlanSponsorDisplay").html('');
    }

    var salesContactsPage = {
        ready: function(){
            this.attachEventHandlers();
        },
        template: function(name, data){
            var templateSrc = $(`[name=${name}]`, $("[name=handlebars-templates]").first()).first().html();
            var tmpl = handlebars.compile(templateSrc);
            return tmpl(data);
        },
        attachEventHandlers: function(){
            var _this = this;
            $("#loadEntityButton").off("click").on("click", function(){
                _this.loadEntity();
            });
            $("#loadPlanSponsorButton").off("click").on("click", function(){
                _this.loadPlanSponsorEntity();
            });
            $("#loadApplicationButton").off("click").on("click", function(){
                _this.loadApplicationEntity();
            });
            $("#quotingLoadPlanSponsorButton").off("click").on("click", function(){
                _this.loadPlanSponsorModel();
            });
            $("#quotingLoadApplicationButton").off("click").on("click", function(){
                _this.loadApplicationModel();
            });
        },
        loadApplicationModel: function(){
            reset();
            setEnvironment();
            envs.refreshToken()
                .then(token => {
                    quoting.setAuth(token);
                    quoting.retrieve("applications", getQuotingApplicationId())
                        .then(applicationModel =>{
                            var application = applicationModel.applicationForm;
                            displayApplication(application);

                            displayEntity(application);
                            setContactsDisplay(application.contacts);
                        })
                })
        },
        loadPlanSponsorModel: function(){
            reset();
            setEnvironment();
            envs.refreshToken()
                .then(token => {
                    quoting.setAuth(token);
                    quoting.retrieve("planSponsors", getQuotingPlanSponsorId())
                        .then(planSponsor => {
                            displayPlanSponsor(planSponsor);

                            displayEntity(planSponsor);

                            setContactsDisplay(planSponsor.primaryCompany.contacts);
                        })
                })
        },
        loadApplicationEntity: function(){
            reset();
            setEnvironment();
            envs.refreshToken()
                .then(token => {
                    entities.setAuth(token);
                    entities.retrieve("Application", getApplicationId())
                        .then(application => {
                            displayApplication(application);

                            displayEntity(application);

                            setContactsDisplay(application.contacts);
                        })
                })
        },
        loadPlanSponsorEntity: function(){
            reset();
            setEnvironment();
            envs.refreshToken()
                .then(token => {
                    entities.setAuth(token);
                    entities.retrieve("PlanSponsor", getPlanSponsorId())
                        .then(planSponsor => {
                            displayPlanSponsor(planSponsor);

                            displayEntity(planSponsor);

                            setContactsDisplay(planSponsor.primaryCompany.contacts);
                        })
                })
        }
    }

    salesContactsPage.ready();

    window.salesContacts = salesContactsPage;
})