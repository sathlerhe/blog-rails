class UserController < ApplicationController
  def index
    render json: User.all
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      render json: @user
    else
      raise Error::BadRequest.new(@user.errors.full_messages)
    end

  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
