class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @search = @categories.search params[:q]
    @categories = @search.result.page(params[:page]).per Settings.per_page
  end
end
