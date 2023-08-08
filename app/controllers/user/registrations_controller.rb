# frozen_string_literal: true
require './lib/errors/errors_handler'

class User::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix
  include Error::ErrorHandler
  respond_to :json

  private

  def respond_with(current_user, _opts = {})
    if resource.persisted?
      render json: current_user
    else
      render json: {
        message:  "User  couldn\'t be created. #{current_user.errors.full_messages.to_sentence}"
      }, status: :unprocessable_entity
    end
  end
end
