class CampaignsController < ApplicationController
    layout "picto_edition_home", only: [:index, :new]
    #before_action :campaign_params, only: [:update]

    def index 
        #binding.pry
        Mailjet.configure do |config|
            config.api_key = ENV['MJ_APIKEY_PUBLIC']
            config.secret_key = ENV['MJ_APIKEY_PRIVATE']
            config.api_version = "v3"
        end
        @campaigns = Mailjet::Campaign.all({From: current_user.email})

        #@campaigns = get_all_campaigns
        #get_all_campaigns[0].attributes["created_at"]
        #@campaigns[0].attributes["custom_value"]
        #binding.pry
    end
    
    def new
        
        @edition = Edition.find(params[:id])
        #@campaign = @edition.campaigns.new(campaign_params)
        #binding.pry
    end

    def create
        
        @edition = Edition.find(params[:id])
        #@campaign = @edition.campaigns.new(campaign_params)
        #IF THE NAME EXISTS IN DATABASE JUST UPDATE THE RECORD !
        @campaign = @edition.campaigns.where( name: params[:name] ).first_or_initialize
        @campaign.assign_attributes(
            type_campaign: params[:type_campaign],
            sender_email: params[:sender_email],
            subject: params[:subject],
            msg: params[:msg]
        )
        #binding.pry
        @campaign.save

        #Create the Campain using MailJet Api

        respond_to do |format|
            format.js 
        end 

    end

    def demmarrer
        emails = params[:selectedEmails]
        emailsParsed = JSON.parse( emails )

        emailsArr = []
        emailsParsed.each do |e|
            # do something
            emailsArr << { 'Email' => e["email"] , 'Name' => e["nom"] }
        end

        campaign_name = params[:nameCampaign] + "-" + emailsParsed[0]["edition_id"].to_s
        get_edition_id_from_campaign_name( "name-of-campaign-7845658" )

        binding.pry

        #contact@kapp10.com
        #Create a Campaign
        require 'json'
        require 'mailjet'
        Mailjet.configure do |config|
            config.api_key = ENV['MJ_APIKEY_PUBLIC'] 
            config.secret_key = ENV['MJ_APIKEY_PRIVATE']
            config.api_version = "v3.1"
        end
        
        variable_campaign = Mailjet::Send.create(messages: [{
            'From'=> {
                'Email'=> 'jemmeli84@gmail.com',
                'Name'=>  'Sportpics'
            },
            'To'=> emailsArr,
            'Subject'=> params[:subjectEmails],
            'TextPart'=> params[:msgEmails],
            'HTMLPart'=> params[:msgEmails],
            'CustomCampaign'=> params[:nameCampaign] + "-" + emailsParsed[0]["edition_id"].to_s ,
            'DeduplicateCampaign'=> true
        }]
        )
        
        @variable_campaign = variable_campaign.attributes['Messages']
        @status = variable_campaign.attributes['Messages'][0]["Status"]

        #binding.pry

        respond_to do |format|
            format.js 
        end 

        
    end

    private

    def campaign_params
        params.permit(
            :name,
            :edition_id,
            :type_campaign,
            :sender_email,
            :subject,
            :msg
        )
    end

    def get_edition_id_from_campaign_name( campaignName )
        #get the last edition ID number number after the name of the Campaign
        #s = "name-of-campaign-7845658"
        campaignName.split('-')[-1]
    end

end