class UserController < ApplicationController
  def create
    @user = User.new(user_params)

    raise Error::BadRequest, @user.errors.full_messages unless @user.valid?

    @user.save
    render json: @user
  end

  def destroy
    current_user = CurrentUser.get_current_user_by_token(request)

    current_user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
