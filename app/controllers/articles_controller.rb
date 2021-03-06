class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    logger.debug("テストのログです")
    @articles = Article.all
#    @articles = @articles.page(params[:page]) 
    @articles = @articles.paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @article = Article.new
  end

  def create
    # @article = Article.new(params[:article])
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
 
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end
