class EditionsController < ApplicationController
  before_action :set_edition, only: [:show, :edit, :update, :destroy, :results, :delete_results, :generate_widget, :generate_photos_widget,
  :generate_diplomas_widget, :generate_diplomas, :delete_diplomas, :send_results]
  helper_method :sort_column, :sort_direction
  #http_basic_authenticate_with name: ENV['ADMIN_LOGIN'], password: ENV['ADMIN_PASSWORD'], except: :widget

  def new
    @event = Event.find(params[:event_id])
    if params[:edition].blank?
      @edition = @event.editions.new(sms_message: I18n.t('sms_message_template'))
    else
      @edition = @event.editions.new(edition_params)
    end
  end

  def create
    @event = Event.find(params[:event_id])
    @edition = @event.editions.new(edition_params)
    if @edition.save
      redirect_to event_path(@edition.event), notice: "Edition créée !"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @edition.update(edition_params)
      upload_results if edition_params[:raw_results]
      redirect_to event_path(@edition.event), notice: "Edition mise à jour."
    else
      render :edit
    end
  end

  def destroy
    @edition.destroy
    respond_to do |format|
      format.html { redirect_to event_path(@edition.event), notice: "Edition effacée." }
    end
  end

  def generate_widget
    GenerateWidgetJob.perform_later(@edition.id)
    redirect_to event_edition_path(@edition.event, @edition), notice: "Le widget est en cours de génération."
  end

  def generate_photos_widget
    p 'launching photos widget generation'
    GeneratePhotosWidgetJob.perform_later(@edition.id)
    redirect_to results_event_edition_path(@edition.event, @edition), notice: "Le Widget Photos est en cours de génération."
  end

  def generate_diplomas_widget
    # p params
    p 'launching diploma widget generation'
    GenerateDiplomasWidgetJob.perform_later(@edition.id)
    redirect_to results_event_edition_path(@edition.event, @edition), notice: "Le Widget Diplômes est en cours de génération."
  end

  def photos_widget
    @edition      = Edition.find(params[:id])
    @categories   = @edition.results.pluck(:categ).uniq.sort
    @photos_json  = @edition.get_widget_photos_json
    @generated_at = Time.now

    render layout: 'photos_widget_layout'
  end  

  def diplomas_widget
    @edition      = Edition.find(params[:id])
    @categories   = @edition.results.pluck(:categ).uniq.sort
    @diplomas_json  = @edition.get_widget_diplomas_json
    @generated_at = Time.now

    render layout: 'diplomas_widget_layout'
  end


  def results
    @runner = @edition.results.empty? ? Result.last : @edition.results.order("RANDOM()").limit(1).first
    @results = @edition.results.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(:per_page => 50, :page => params[:page])
    @diplomas = []
    @results.each do |r|
      if r.diploma.url
        @diplomas << {
          # diploma: r.diploma,
          id: r.id,
          url: r.diploma.url
        }
      end
    end
    # p @diplomas
  end

  def delete_results
    @edition.results.delete_all
    redirect_to event_edition_path(@edition.event, @edition), notice: "Les résultats ont été supprimés"
  end

  def generate_diplomas
    @edition.generate_diplomas
    redirect_to event_edition_path(@edition.event, @edition), notice: "Les diplômes sont en cours de génération."
  end

  def delete_diplomas
    @edition.delete_diplomas
    redirect_to event_edition_path(@edition.event, @edition), notice: "Les diplômes ont été supprimés."
  end

  def send_results
    if PERFORM_SENDING
      #on parse le champ hashtag pour découper les hashtags présents
      complete_hash_tag = ''
      if @edition.hashtag
        hash_tags = @edition.hashtag.strip.split(/\s+/)
        #on ajoute un # si absent du hashtag
        hash_tags.each do |hash_tag|
          complete_hash_tag = complete_hash_tag+"#{hash_tag.start_with?('#') ? '' : '#'}#{hash_tag} "
        end
      end

      @edition.results.find_each do |result|
        SendResultJob.perform_later(result.id)
      end
      redirect_to event_edition_path(@edition.event, @edition), notice: "#{@edition.results.count} résultats en cours d'envoi." and return
    else
      redirect_to event_edition_path(@edition.event, @edition), alert: "L'envoi des résutats est bloqué sur l'environnement de #{Rails.env}"
    end
  end

  private

  def set_edition
    @edition = Edition.find(params[:id])
  end

  def edition_params
    params.require(:edition).permit(
        :id,
        :date,
        :description,
        :email_sender,
        :email_name,
        :hashtag,
        :results_url,
        :sms_message,
        :raw_results,
        :background_image,
        :template,
        :external_link,
        :external_link_button,
        :event_id,
        :sendable_at_home,
        :sendable_at_home_price,
        :download_chargeable,
        :download_chargeable_price,
        :registration_link,
    )
  end

  def sort_column
    @edition.results.column_names.include?(params[:sort]) ? params[:sort] : "rank"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def upload_results
    UploadResults.new(@edition.id).call
  end
end
