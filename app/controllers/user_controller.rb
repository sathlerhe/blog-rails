class UserController < ApplicationController
  def create
    @user = User.new(user_params)

    raise Error::BadRequest, @user.errors.full_messages unless @user.valid?

    @user.save
    render json: @user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
