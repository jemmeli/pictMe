class EventsController < ApplicationController
  before_action :authenticate_user!
  layout "picto", only: [:list_picto, :home_picto, :new_event_picto]
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
    #show only the events related to the current user
    #@events = Event.all.limit(5)
    @events = current_user.events.pictme
    @eventsfreshAdded = current_user.events.freshAdded
  end

  def home_picto
    @months = ["janvier" ,"février" ,"mars" ,"avril" ,"mai" ,"juin" ,"juillet" ,"août" ,"septembre" ,"octobre" ,"novembre" ,"décembre"]
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
    @events = Event.serach( params[:q] )
  end

  def add_fresh_event
    eventFresh = Event.find( params[:pickedEventID] )
    #here we can extract the freshstart editions with
    # @editionsFresh = @eventFresh.editions
    @event = eventFresh.dup
    @event.user = current_user#belongs_to
    @event.name = eventFresh.name + " Cloned "
    @event.pictme = eventFresh.id
    @event.save
    #binding.pry
  end

  def new_event_picto
    @event = Event.new
  end

  def create_event_picto
    @event = Event.new(event_params)
    @event.pictme = "true"
    @event.user_id = current_user.id
    
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

    if @event.save
      if eventName && eventPlace && eventCountry && eventAdress && eventDepartment && eventWebsite && eventFacebook && eventInstagram && eventFname && eventLname && eventEmail && eventPhone
        redirect_to home_picto_event_path( @event.id ), notice: "Evènement créé !"
      else
        redirect_to home_picto_event_path( @event.id ), notice: "Evènement créé ! Merci de Completer Vos Informations"
      end
    else
      redirect_to new_event_picto_path, notice: "Evènement n'est pas créé !"
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
