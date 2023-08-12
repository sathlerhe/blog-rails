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

    render json: { message: "success" }, status: 200
  end

  def update
    current_user = CurrentUser.get_current_user_by_token(request)
    current_user.update(user_params)

    raise Error::BadRequest, current_user.errors.full_messages unless current_user.valid?

    render json: current_user
  end

  def user_articles
    @user = User.find(params[:id])
    @articles = @user.articles.all

    res = {
      name: @user.name,
      email: @user.email,
      articles: @articles
    }

    render json: res
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
