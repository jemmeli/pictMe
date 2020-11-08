class EventsController < ApplicationController
  before_action :authenticate_user!
  layout "picto", only: [:list_picto, :home_picto, :new_event_picto, :filter_events]
  require 'csv'
  before_action :set_event, only: [:show, :edit, :update, :destroy, :home_picto, :update_event_picto]

  # disable the filter for for all actions in this controller
  before_filter :disable_filter_pict_home!
  # enable the filter for action list_picto in this controller
  before_filter :enable_filter_pict_home!, :only => [:list_picto]



  def index
    @events = Event.order('created_at desc').limit(20)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: "Evènement créé !"
    else
      render :new
    end
  end

  def show
    @client_1 = @event.client_1.blank? ? nil : Client.find(@event.client_1)
    @client_2 = @event.client_2.blank? ? nil : Client.find(@event.client_2)
    @client_3 = @event.client_3.blank? ? nil : Client.find(@event.client_3)
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Evènement mis à jour."
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_path, notice: "Evènement effacé." }
    end
  end

  def upload
  end

  def import
    begin
      Event.import(params['file'])
      redirect_to root_path, notice: 'Evènements importés'
    rescue StandardError => e
      p e
      redirect_to root_path, notice: "Erreur: impossible d'importer les évènements"
    end
  end

  #=================
  #Events for Picto
  #=================
  def list_picto
    #get the list of all races type
    @courcesType = Race.all.distinct.pluck(:race_type)

    #show only the events related to the current user
    #@events = Event.all.limit(5)

    #@events = current_user.events.pictme.order( created_at: :desc )
    #@eventsfreshAdded = current_user.events.fresh
    @events = current_user.events.order( created_at: :desc )
    #binding.pry

    #For sorting
    order = params[:option]
    if ( order == "asc" )
      @events = current_user.events.order( name: :asc )
    end
    if ( order == "desc" )
      @events = current_user.events.order( name: :desc )
    end
    if ( order == "newest" )
      @events = current_user.events.order( created_at: :desc )
    end
    if ( order == "oldest" )
      @events = current_user.events.order( created_at: :asc )
    end
    
  end

  def home_picto
    @months = ["janvier" ,"février" ,"mars" ,"avril" ,"mai" ,"juin" ,"juillet" ,"août" ,"septembre" ,"octobre" ,"novembre" ,"décembre"]
    #detect if belong to freshstart == "false"
    @is_freshstart = @event.pictme

    #if params[:duplicate] == "duplicate"

      #eventToDuplicate = Event.find( params[:id] )
      #@event = eventToDuplicate.dup
      #@event.name = eventToDuplicate.name + " Dupliqué "

      #if @event.save
        #redirect_to home_picto_event_path( @event.id ), notice: "Evènement Dupliqué."
      #else
        #redirect_to root_path, alert: "Evènement n'a pas Dupliqué."
      #end

    #end

  end

  def update_event_picto

    if eventUpdated?
      if @event.update(event_params)
        redirect_to home_picto_event_path, notice: "Evènement mis à jour."
      else
        render home_picto_event_path , notice: "Evènement n'est pas enregister."
      end
    end

    if eventDeleted?
      #binding.pry
      if params[:xxx] == "SUPPRIMER"
        if @event.editions.any?
          @event.editions.each { |edition| edition.destroy }
        end
        if @event.destroy
        end

        redirect_to root_path, notice: "Evènement supprimer"
      else
        redirect_to home_picto_event_path( @event.id ), alert: "Evènement n'est pas supprimer , merci d'ecrire 'supprimer'"
      end
    end

  end

  def search_events
    #all events in pictme => user.events (replace freshAdded)
    #all events in freshstart => Event.fresh.all

    #@freshAddedIndex = current_user.events.all.distinct.freshAdded.pluck(:pictme)
    @freshAddedIndex = current_user.events.all.distinct.pluck(:id)
    @freshAddedIndex = @freshAddedIndex.map!{|e| e.to_i}
    @freshAddedIndex = @freshAddedIndex.to_json.html_safe
    #search events
    @events = Event.fresh.serach( params[:q] )
    #binding.pry
  end

  def filter_events

    @courcesType = Race.all.distinct.pluck(:race_type)
    @eventsfreshAdded = current_user.events.freshAdded


    date = params[:date]
    dateArray = date.split(' ~ ')
    filterHash = {}

    dateArray[ 0 ].nil? ? dateStart = "01/01/1970" : dateStart = dateArray[ 0 ]
    dateArray[ 1 ].nil? ? dateEnd = "01/01/2222" : dateEnd = dateArray[ 1 ]

    departement = params[:departement]
    course = params[:course]

    filterHash[:dateStart] = dateStart
    filterHash[:dateEnd] = dateEnd
    filterHash[:departement] = departement
    filterHash[:course] = course

    @events = Event.filterEvents( filterHash )
    
    if @events.present? 
      flash.now[:notice] = 'Filtre effectuer'
    else
      flash.now[:alert] = 'Pas de evénement personnel trouver'
    end
    #binding.pry
  end

  def add_fresh_event
    
    @event = Event.find( params[:pickedEventID] )
    #many to many through
    current_user.events << @event
    #@event.users << current_user

    #@event.user = current_user#belongs_to
    #@event.name = eventFresh.name + " Cloned "
    #@event.pictme = eventFresh.id
    #@event.save
    #binding.pry
  end

  def new_event_picto
    @event = Event.new
  end

  def create_event_picto
    @event = Event.new(event_params)
    @event.pictme = "true"
    @event.user_id = current_user.id

    #many to many
    #current_user.events << @event
    #@event.users << current_user
    
    eventName = params["event"]["name"].present?
    eventPlace = params["event"]["place"].present?
    eventCountry = params["event"]["country"].present?
    eventAdress = params["event"]["adress"].present?
    eventDepartment = params["event"]["department"].present?
    eventWebsite = params["event"]["website"].present?
    eventFacebook = params["event"]["facebook"].present?
    eventInstagram = params["event"]["instagram"].present?
    eventFname = params["event"]["f_name"].present?
    eventLname = params["event"]["l_name"].present?
    eventEmail = params["event"]["email"].present?
    eventPhone = params["event"]["phone"].present?

    #many to many through
    if( current_user.events << @event )
      if eventName && eventPlace && eventCountry && eventAdress && eventDepartment && eventWebsite && eventFacebook && eventInstagram && eventFname && eventLname && eventEmail && eventPhone
        redirect_to home_picto_event_path( @event.id ), notice: "Evènement créé !"
      elsif !eventName
        redirect_to new_event_picto_path, alert: "Evènement n'est pas créé !"
      else
        redirect_to home_picto_event_path( @event.id ), notice: "Evènement créé ! Merci de Completer Vos Informations"
      end
    else
      redirect_to new_event_picto_path, alert: "Le champs Nom de l'événement est obligatoire."
    end
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
        :id,
        :name,
        :place,
        :website,
        :facebook,
        :twitter,
        :instagram,
        :contact,
        :email,
        :phone,
        :client_1,
        :client_2,
        :client_3,
        :department,
        :challenge_id,
        :global_challenge,
        :country,
        :adress,
        :pictme,
        :user_id,
        :f_name,
        :l_name
    )
  end

  #PictMe
  def eventDeleted?
    params[:commit] == "Supprimer l'événement"
  end

  def eventUpdated?
    params[:commit] == "Enregistrer"
  end

end
