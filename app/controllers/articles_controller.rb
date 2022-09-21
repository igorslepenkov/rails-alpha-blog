class ArticlesController < ApplicationController
  before_action :find_article_with_params_id, only: %i[show edit update destroy]

  def index
    @articles = Article.all
  end

  def show; end

  def new; end

  def edit; end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = 'Article was created successfully'
      redirect_to @article
    else
      render 'new', status: :bad_request
    end
  end

  def update
    @article.update(article_params)
    if @article.save
      redirect_to @article
      flash[:notice] = 'Article has been updated'
    else
      render 'edit', status: :bad_request
    end
  end

  def destroy
    redirect_to(articles_path)
    @article.destroy
    flash[:notice] = "Article #{@article.id} has been destroyed"
  end

  private

  def find_article_with_params_id
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
