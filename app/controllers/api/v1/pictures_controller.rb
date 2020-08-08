class API::V1::PicturesController < API::V1::ApplicationController
    before_action :set_edition, only: [:index]
    skip_before_action :doorkeeper_authorize!

    #http://localhost:3000/api/v1/events/30/editions/{id : 7}/pictures
    def index
        @pictures = @edition.pictures
        render json: @pictures
    end



    private

    def set_edition
        @edition = Edition.find_by(id: params[:id]) if params[:id]
    end

end