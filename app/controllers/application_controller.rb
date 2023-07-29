require './lib/errors/errors_handler'

class ApplicationController < ActionController::API
  include Error::ErrorHandler
end
