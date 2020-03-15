class ApplicationController < ActionController::Base

  layout :layout_login
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  add_flash_types :success, :warning, :danger, :info

  def enable_filter_pict_home!
    @has_filter_pict_home = true
  end

  def disable_filter_pict_home!
    @has_filter_pict_home = false
  end


  private
  #https://github.com/heartcombo/devise/wiki/How-To:-Create-custom-layouts
  def layout_login
    if devise_controller?
      "login"
    end
  end

end
