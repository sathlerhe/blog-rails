class ArticleController < ApplicationController
  def index
    title = "%#{params[:title]}%"
    if params[:order]
      order = params[:order].downcase == 'asc' ? :asc : :desc
    else
      order = :desc
    end

    @articles = Article.joins(:user).where("title LIKE ?", title).order(created_at: order)
    @articles_with_author = []

    @articles.each do |article|
      article_with_author = article.attributes.merge!(
        author: {
          name: article.user.name,
          email: article.user.email
        }
      )

      @articles_with_author.push(article_with_author)
    end

    render json: @articles_with_author
  end

  def show
    @article = Article.joins(:user).find(params[:id])
    @article_with_author = @article.attributes.merge!(
      author: {
        name: @article.user.name,
        email: @article.user.email
      }
    )

    render json: @article_with_author
  end

  def create
    current_user = CurrentUser.get_current_user_by_token(request)

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

  def destroy
    current_user = CurrentUser.get_current_user_by_token(request)

    current_user.articles.find(params[:id]).destroy

    render json: { message: "success" }, status: 200
  end

  def update
    current_user = CurrentUser.get_current_user_by_token(request)

    @article = current_user.articles.find(params[:id])
    @article.update(article_params)

    raise Error::BadRequest, current_user.errors.full_messages unless @article.valid?

    render json: @article
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
