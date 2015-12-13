class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    names = [:first_name, :last_name]
    other_details = [:occupation, :country]
    devise_parameter_sanitizer.for(:sign_up) << names
    devise_parameter_sanitizer.for(:account_update) << names + other_details
  end

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  def check_if_active
    sign_out if current_user.inactive?
  end
end
