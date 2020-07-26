class PicturesController < ApplicationController
  layout "picto_edition_home", only: [:new, :show, :index, :edit]
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :set_edition, only: [:new, :index, :create, :update]
  before_filter :disable_filter_pict_home!

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = @edition.pictures.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = @edition.pictures.new(picture_params)

    respond_to do |format|
      if @picture.save
        format.html { redirect_to event_pictures_path( params[:event_id], params[:id] ), notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: api_v1_event_picture_url(@edition, @picture) }
        #format.json { head :no_content }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: api_v1_event_picture_url(@edition,@picture) }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to event_pictures_path(params[:event_id], params[:id]), notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = @edition.pictures.find(params[:picture_id])
    end

    def set_edition
      @edition = Edition.find( params[:id] )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:image)
    end
end
