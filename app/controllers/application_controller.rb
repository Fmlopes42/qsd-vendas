class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_menus, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_current_location, unless: :devise_controller?

  def set_menus
    scope = menu_scope

    @left_menu = "left_#{scope}_menu"
    @top_menu = "top_#{scope}_menu"
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private

  def menu_scope
    menu_scope = 'visitor'
    menu_scope = current_user.role if user_signed_in?
    menu_scope
  end

  def store_current_location
    store_location_for(:user, request.url)
  end
end
