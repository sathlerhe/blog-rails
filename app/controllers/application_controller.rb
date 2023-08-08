require './lib/errors/errors_handler'
require './lib/helpers/get_current_user_by_token'

class ApplicationController < ActionController::API
  include Error::ErrorHandler

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
  end
end
