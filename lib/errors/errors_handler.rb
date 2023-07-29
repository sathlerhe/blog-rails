module Error
  module ErrorHandler
    def self.included(clazz)
      clazz.class_eval do
        rescue_from StandardError do |e|
          respond(e.to_s, 500)
        end

        rescue_from CustomError do |e|
          respond(e.message, e.status)
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          respond(e.to_s, 404)
        end
      end
    end

    private

    def respond(_message, _status)
      json = { error: _message, status: _status }.as_json
      render json: json, status: _status
    end
  end

  class CustomError < StandardError
    attr_reader :status, :message

    def initialize(_message = nil, _status = nil)
      @status = _status || 422
      @message = _message || 'Something went wrong'
    end
  end

  class BadRequest < CustomError
    def initialize(message = 'One or more arguments are wrong.')
      super(message, 400)
    end
  end
end
