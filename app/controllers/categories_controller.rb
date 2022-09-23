class CategoriesController < ApplicationController
  def index; end

  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category was created'
      redirect_to @category
    else
      render 'new', status: :bad_request
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
