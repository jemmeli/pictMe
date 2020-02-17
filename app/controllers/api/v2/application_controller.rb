class API::V2::ApplicationController < ActionController::Base
  include ActionController::Serialization

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  force_ssl if Rails.env.production?

  before_action :doorkeeper_authorize! unless Rails.env.test?

  def index
    render json: :method_not_allowed, status: :method_not_allowed
  end

  def show
    render json: :method_not_allowed, status: :method_not_allowed
  end

  def new
    render json: :method_not_allowed, status: :method_not_allowed
  end

  def create
    render json: :method_not_allowed, status: :method_not_allowed
  end

  def update
    render json: :method_not_allowed, status: :method_not_allowed
  end

  def destroy
    render json: :method_not_allowed, status: :method_not_allowed
  end

  def edit
    render json: :method_not_allowed, status: :method_not_allowed
  end

  def not_authenticated
    render json: :unauthorized, status: :unauthorized
  end

  protected

  def default_serializer_options
    {root: false}
  end

end
