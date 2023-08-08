class ArticleController < ApplicationController
  def index
    @articles = Article.joins(:user)
    @articles_with_author = []

    @articles.each do |article|
      article_with_author = article.attributes.merge!(author: {
        name: article.user.name,
        email: article.user.email
      })

      @articles_with_author.push(article_with_author)
    end

    render json: @articles_with_author
  end

  def show
    @article = Article.joins(:user).find(params[:id])
    @article_with_author = @article.attributes.merge!(author: {
      name: @article.user.name,
      email: @article.user.email
    })

    render json: @article_with_author
  end

  def create
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
      current_user = User.find(jwt_payload['sub'])
    else
      raise Error::Unauthorized
    end

    payload = article_params
    payload[:user_id] = current_user[:id]
    @article = current_user.articles.new(payload)


    if @article.valid?
      @article.save
      render json: @article
    else
      render json: @article.errors.full_messages, status: :bad_request
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
