class API::V1::PicturesController < API::V1::ApplicationController
    before_action :set_edition, only: [:index]
    before_action :set_picture, only: [:destroy]
    skip_before_action :doorkeeper_authorize!

    #http://localhost:3000/api/v1/events/30/editions/{edition_id : 7}/pictures
    def index
        @pictures = @edition.pictures
        render json: @pictures
    end

    #http://localhost:3000/api/v1/events/30/editions/{edition_id : 7}/pictures/:id
    def destroy
        @picture.destroy
        head :no_content
    end



    private

    def set_edition
        @edition = Edition.find_by(id: params[:edition_id]) if params[:edition_id]
    end

    def set_picture
        @picture = Picture.find(id: params[:id])
    end

end