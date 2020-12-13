class EditionsController < ApplicationController
  layout "picto_edition_home", only: [:home_picto_edition, :contacts_picto_edition, :upload_csv_picto, :get_campaign_detail, :diffuser_photo]
  before_action :set_edition, only: [:show, :edit, :update, :destroy, :results, :delete_results, :generate_widget, :generate_photos_widget,
  :generate_diplomas_widget, :generate_diplomas, :delete_diplomas, :send_results, :home_picto_edition, :contacts_picto_edition, :get_campaign_detail, :diffuser_photo]
  helper_method :sort_column, :sort_direction
  #skip_before_filter :verify_authenticity_token, :only => :upload_csv_picto
  #http_basic_authenticate_with name: ENV['ADMIN_LOGIN'], password: ENV['ADMIN_PASSWORD'], except: :widget
  #respond_to :js, only: :process_csv_picto

  # disable the filter for for all actions in this controller
  before_filter :disable_filter_pict_home!

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
    #redirect_to event_edition_path(@edition.event, @edition), notice: "Le widget est en cours de génération."
    redirect_to diffuser_photo_event_edition_path(@edition.event, @edition), notice: "Le widget est en cours de génération."
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


  #=================
  # for Picto
  #=================
  def home_picto_edition
    @has_filter_pict_home = false
    @totalContacts = Contact.where( edition_id: params[:id] ).count || 0
    @totalContactsWithEmail = Contact.where("(edition_id = "+params[:id]+") AND (email IS NOT NULL)").count || 0
    @totalContactsWithSMS = Contact.where("(edition_id = "+params[:id]+") AND (telephone IS NOT NULL)").count || 0
    
    #binding.pry
  end

  def contacts_picto_edition
    gon.firstRowCsv = session[:firstRowCsv]
  end

  def send_email_modal
    #send an email for modal send email
    #byebug
    begin
      SendEmailModalMailer.help_csv(params).deliver
      flash[:success] = 'Email est envoyer'
      redirect_to contacts_picto_edition_event_edition_path
    rescue StandardError => e
      # do something with the messages in exception object e
      flash[:error] = "#{e.class}Probléme envoie du Email , #{e.message}"
      redirect_to contacts_picto_edition_event_edition_path
    end
  end


  #def process_csv_picto
    #read the CSV
    #readCsv= CSV.parse open( params[:edition][:description].path ).read, :headers=>true, :converters=>:numeric
    #session[:firstRowCsv] = readCsv.first
    #session[:pathCsv] = params[:edition][:description].path
  #end

  def upload_csv_picto
      
    #process_csv_picto
    readCsv = CSV.parse open( params[:edition][:description].path ).read, :headers=>true, :converters=>:numeric
    #session[:firstRowCsv] = readCsv.first
    pathCsv = params[:edition][:description].path

  
    counter = 0
    CSV.foreach(pathCsv,  headers: true) do |row|
      #binding.pry
      contact = Contact.where( email: row["Email"], edition_id: params[:id] ).first_or_initialize
      contact.assign_attributes(
          telephone: row["Telephone"],
          email: row["Email"],
          dossard: row["Doss"],
          nom: row["Nom"],
          prenom: row["Prenom"],
          edition_id: params[:id]
      )
      if contact.save
        counter += 1
      else
        #show eny error msg
        puts "#{email} - #{user.errors.full_messages.join(",")}" if user.errors.any?
      end

    end
    #after import redirect to Contact page throu .js.erb page
  end

  def diffuser_photo

  end

  def add_edition_picto

    @event = Event.find(params[:id])

    day = params[:day]
    month = params[:month]
    year = params[:year]
    dateFrenchFormat = day + "/" + month + "/" + year

    if Date.valid_date?( year.to_i, month.to_i, day.to_i )
      #date existe
      date = DateTime.parse( dateFrenchFormat )
      @edition = @event.editions.create( date: date.to_date, description: "description edition"  )
    
      if @edition.save
        redirect_to home_picto_event_path( @event.id ), notice: "Edition créée !"
      else
        redirect_to home_picto_event_path( @event.id ), alert: "Edition n'est pas créée !"
      end
    else
      #date n'existe pas
      redirect_to home_picto_event_path( @event.id ), alert: "corriger la date "+ dateFrenchFormat +" n'esxiste pas "
    end

  end


  def get_campaign_detail
    campaign_id = params[:campaign_id]
    @emailsArrays = []
    statusArrays = []
    n = 0

    Mailjet.configure do |config|
      config.api_key = ENV['MJ_APIKEY_PUBLIC']
      config.secret_key = ENV['MJ_APIKEY_PRIVATE']
      config.api_version = "v3"
    end
    contactsArrays = Mailjet::Contact.all({  campaign: campaign_id, status: true })

    contactsArrays.each do |item| 
      @emailsArrays.push( { "contact_id".to_sym => item.id, "email".to_sym => item.email } )
    end

    #[{:contact_id=>3198875369, :email=>"jemmeli666@gmail.com"}, 
    #{:contact_id=>3198875370, :email=>"selfskillsimprove@gmail.com"}]

    @emailsArrays.each_with_index do |item, index| 
      Mailjet.configure do |config|
        config.api_key = ENV['MJ_APIKEY_PUBLIC']
        config.secret_key = ENV['MJ_APIKEY_PRIVATE']
        config.api_version = "v3"
      end
      status = Mailjet::Message.all({  campaign: campaign_id.to_i, contact: item[:contact_id] })
      #binding.pry

      status.each do |st|
        @emailsArrays[ index ][:status] = st.status
        pictmeContact = Contact.where(email: item[:email], edition_id: params[:id])
        @emailsArrays[ index ][:nom] = pictmeContact.first.nom
        @emailsArrays[ index ][:telephone] = pictmeContact.first.telephone
        @emailsArrays[ index ][:dossard] = pictmeContact.first.dossard
        @emailsArrays[ index ][:prenom] = pictmeContact.first.prenom
      end
    end

    #binding.pry
    @emailsArrays = @emailsArrays.to_json
  end

  def change_bib_contact
      if params[:current_id_picture].present?
        picture = Picture.find( params[:current_id_picture] )
        picture.bib = params[:dossard]
        #binding.pry
        picture.save
        redirect_to event_pictures_path( params[:event_id], params[:id] ), notice: "Dossard Ajouter !"
      else
        redirect_to event_pictures_path( params[:event_id], params[:id] ), alert: "Dossard n'est pas Ajouter !"
      end
  end

  def duplicate_picto
    event = Event.find( params[:event_id] )
    editionToDuplicate = Edition.find( params[:id] )
    @edition = editionToDuplicate.dup

    if @edition.save
      redirect_to home_picto_event_path( @edition.event.id ), notice: "Edition Dupliqué."
    else
      redirect_to root_path, alert: "Edition n'a pas Dupliqué."
    end

  end

  def supprimer_picto
    @edition = Edition.find(  params[:id]  )
    @edition.destroy
    respond_to do |format|
      format.html { redirect_to home_picto_event_path(@edition.event.id), notice: "Edition effacée." }
    end
  end

  #=================
  # END for Picto
  #=================

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
