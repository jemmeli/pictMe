class API::V1::ContactsController < API::V1::ApplicationController
    before_action :set_edition, only: [:index]
    skip_before_action :doorkeeper_authorize!

    #http://localhost:3000/api/v1/editions/{edition_id : 7}/contacts
    def index
        @contacts = @edition.contacts
        render json: @contacts
    end


    private

    def set_edition
        @edition = Edition.find_by(id: params[:edition_id]) if params[:edition_id]
    end
    
end