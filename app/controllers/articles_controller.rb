class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new; end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :description))
    if @article.save
      flash[:notice] = 'Article was created successfully'
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    @article.update(params.require(:article).permit(:title, :description))
    if @article.save
      redirect_to @article
      flash[:notice] = 'Article has been updated'
    else
      render 'edit'
    end
  end
end
