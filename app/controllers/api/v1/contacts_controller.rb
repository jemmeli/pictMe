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


    private

    def set_edition
        @edition = Edition.find_by(id: params[:edition_id]) if params[:edition_id]
    end
    
end