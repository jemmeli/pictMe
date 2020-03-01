class RacesController < ApplicationController
  protect_from_forgery with: :exception,  except: :widget
  before_action :set_race, except: [:index, :new, :create, :regenerate_all_widgets]
	helper_method :sort_column, :sort_direction
  #http_basic_authenticate_with name: ENV['ADMIN_LOGIN'], password: ENV['ADMIN_PASSWORD'], except: :widget

  def index
    @races = Race.order('date desc')
  end

  def new
    @race = Race.new(edition_id: params[:edition_id])
  end

  def edit
    @event = @race.edition.event unless @race.edition.nil?
    @event = Event.find(params[:event_id]) if params[:event_id]
  end

  def show
		@results = @race.results.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 50, :page => params[:page])
  end

  def widget
    response.headers.except! 'X-Frame-Options'
    render layout: false
  end

  def create
    @race = Race.new(race_params)

    respond_to do |format|
      if @race.save
        format.html { redirect_to event_edition_path(@race.event, @race.edition), notice: 'Course créée.' }
        format.json { render :show, status: :created, location: @race }
      else
        p @race.errors
        format.html { render :new }
        format.json { render json: @Race.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /races/1
  # PATCH/PUT /races/1.json
  def update

    @photos = params[:race][:photos] || []
    params[:race].delete(:photos)

    respond_to do |format|
      if @race.update(race_params)
        decode_results if race_params[:raw_results]
        @photos.each do |photo|
          @race.photos.create({image: photo})
        end

        format.html { redirect_to event_edition_path(@race.edition.event, @race.edition), notice: 'Course mise à jour.' }
        format.json { render :show, status: :ok, location: @race }
      else
        format.html { render :edit }
        format.json { render json: @Race.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /races/1
  # DELETE /races/1.json
  def destroy
    @race.destroy
    respond_to do |format|
      format.html { redirect_to event_edition_path(@race.edition.event, @race.edition), notice: 'Course supprimée.' }
      format.json { head :no_content }
    end
  end

  def generate_widget
    GenerateWidgetJob.perform_later(@race.id)
    redirect_to @race, notice: "Le widget est en cours de génération."
  end

	# Generate all widgets already generated
	def regenerate_all_widgets
		races = Race.all
		races.each do |race|
			unless race.widget_generated_at.nil?
				GenerateWidgetJob.perform_later(race.id)
			end
		end
		redirect_to races_path, notice: "Les widgets sont en cours de génération."
	end

	def generate_photos_widget
		GeneratePhotosWidgetJob.perform_later(@race.id)
    redirect_to @race, notice: "Le widget de photos est en cours de génération."
	end

  def generate_diplomas
    @race.generate_diplomas
    redirect_to @race, notice: "Les diplômes sont en cours de génération."
  end

  def delete_results
    @race.results.delete_all
    redirect_to @race, notice: "Les résultats ont été supprimés"
  end

  def delete_diplomas
    @race.delete_diplomas
    redirect_to race_path(@race.id), notice: "Les diplômes ont été supprimés."
  end

  def duplicate
    @new_race = Race.create( name: @race.name + "_#{Time.now}",
      date: @race.date,
      email_sender: @race.email_sender,
      email_name: @race.email_name,
      hashtag: @race.hashtag,
      template: @race.template,
      results_url: @race.results_url,
      sms_message: @race.sms_message
    )
    Rails.logger.debug @new_race.errors.to_json
    redirect_to @new_race, notice: "La course est dupliquée."
  end

  def send_results
    if PERFORM_SENDING
      #on parse le champ hashtag pour découper les hashtags présents
      complete_hash_tag = ''
      if @race.hashtag
        hash_tags = @race.hashtag.strip.split(/\s+/)
        #on ajoute un # si absent du hashtag
        hash_tags.each do |hash_tag|
            complete_hash_tag = complete_hash_tag+"#{hash_tag.start_with?('#') ? '' : '#'}#{hash_tag} "
          end
      end

      @race.results.find_each do |result|
        SendResultJob.perform_later(result.id)
      end
      redirect_to races_url, notice: "#{@race.results.count} résultats en cours d'envoi." and return
    else
      redirect_to races_url, alert: "L'envoi des résultats est bloqué sur l'environnement de #{Rails.env}"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end

  def race_params
    params.require(:race).permit(
      :id,
      :name,
      :edition_id,
      :coef,
      :category,
      :department,
      :race_type,
      :start_at,
      :distance,
    )
  end

  def decode_results
    DecodeResultsFileJob.perform_later(@race.id)
  end

	def sort_column
		@race.results.column_names.include?(params[:sort]) ? params[:sort] : "rank"
  end

  def sort_direction
		%w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end
end
