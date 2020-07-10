class API::V1::ContactsController < API::V1::ApplicationController
    before_action :set_edition, only: [:index]
    skip_before_action :doorkeeper_authorize!

    #http://localhost:3000/api/v1/editions/{edition_id : 7}/contacts
    def index
        @contacts = @edition.contacts
        render json: @contacts
    end
    #http://localhost:3000/api/v1/editions/{edition_id : 7}/getCampaigns
    def getCampaigns
        Mailjet.configure do |config|
            config.api_key = ENV['MJ_APIKEY_PUBLIC']
            config.secret_key = ENV['MJ_APIKEY_PRIVATE']
            config.api_version = "v3" 
        end
        #Get All Campaign belong to current user
        variable = Mailjet::Campaign.all({From: current_user.email})
        #binding.pry
        render json:  variable 
    end

    #http://localhost:3000/api/v1/editions/{edition_id : 7}/getCampaignInfoByID
    def getCampaignInfoByID
        Mailjet.configure do |config|
        config.api_key = ENV['MJ_APIKEY_PUBLIC']
        config.secret_key = ENV['MJ_APIKEY_PRIVATE']
        config.api_version = "v3"
        end

        #get the campaign id from AJAX AngularJS
        campaignID = params[:campaignID]

        #variable = Mailjet::Campaign.all({  custom_campaign: "test7-7"  })
        variable = Mailjet::Campaign.all({  id: campaignID  })
    	
        #campaign: 7695020782
        #subject : subject test7
        #title : test7-7
        
        #p variable.attributes['Data']
        #binding.pry
        render json:  variable 
    end

    #http://localhost:3000/api/v1/editions/{edition_id : 7}/getAllContactByCampaign
    def getAllContactByCampaign
        Mailjet.configure do |config|
        config.api_key = ENV['MJ_APIKEY_PUBLIC']
        config.secret_key = ENV['MJ_APIKEY_PRIVATE']
        config.api_version = "v3"
        end
        variable = Mailjet::Contact.all({  campaign: 7695020782, status: true })
        #p variable.attributes['Data']
        #binding.pry
        render json:  variable 
    end

    #http://localhost:3000/api/v1/editions/{edition_id : 7}/getContactStatus
    def getContactStatus
        Mailjet.configure do |config|
        config.api_key = ENV['MJ_APIKEY_PUBLIC']
        config.secret_key = ENV['MJ_APIKEY_PRIVATE']
        config.api_version = "v3"
        end
        #get the campaign id from AJAX AngularJS
        campaign = params[:campaign]
        #get the contact id from AJAX AngularJS
        contact = params[:contact]
        #variable = Mailjet::Message.all({  campaign: 7695020782, contact: 3198875370 })
        variable = Mailjet::Message.all({  campaign: campaign, contact: contact })
        #p variable.attributes['Data']
        #binding.pry
        render json:  variable 
    end

    #$.get("bugs/get_values_from_models", {id: your_id}, function(data){
        #do something with your data received if everything went ok.
        #notice that you'll have to return json from your controller.
    #}, "json");

    #Response
    #...
    #"spamass_rules": "",
    #"state_permanent": false,
    #"status": "sent/opened/clicked/spam/unsub/.........",
    #"subject": "",
    #...


    private

    def set_edition
        @edition = Edition.find_by(id: params[:edition_id]) if params[:edition_id]
    end
    
end