class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @search = @categories.search params[:q]
    @categories = @search.result.page(params[:page]).per Settings.per_page
  end
  
  def show
    @search = @category.words.search params[:q]
    @words = @search.result.page(params[:page]).per Settings.per_page
    @lesson = @category.lessons.build
    @lesson.user = current_user
  end
end
