class EventsController < ApplicationController
  require 'csv'
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    byebug
    @events = Event.order('created_at desc')
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
        :global_challenge
    )
  end
end
