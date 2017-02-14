class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_menus, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_current_location, :unless => :devise_controller?

  def set_menus
    @menu = 'left_visitor_menu'
    @top_menu = user_signed_in? ? 'top_user_menu' : 'top_visitor_menu'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end


  private

  def store_current_location
    store_location_for(:user, request.url)
  end
end
