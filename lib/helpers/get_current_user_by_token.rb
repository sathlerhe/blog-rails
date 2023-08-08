class CurrentUser
  def self.get_current_user_by_token(request)
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
      current_user = User.find(jwt_payload['sub'])
    else
      raise Error::Unauthorized
    end
  end
end
