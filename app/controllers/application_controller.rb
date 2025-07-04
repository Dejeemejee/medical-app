class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :log_params
  

  protected
  def log_params
     Rails.logger.debug ">>> PARAMS: #{params.inspect}"
  end

  def configure_permitted_parameters
    added_attrs = [:first_name, :last_name, :role, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end
end
