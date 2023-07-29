class ArticleController < ApplicationController
  def index
    render json: Article.all
  end

  def create
    payload = article_params
    @author = User.find(payload[:user_id])

    @article = @author.articles.new(payload)


    if @article.valid?
      @article.save
      render json: @article
    else
      render json: @article.errors.full_messages, status: :bad_request
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :user_id)
  end
end
