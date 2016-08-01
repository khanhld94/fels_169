class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource
  
  def new 
  end

  def create
    if @category.save
      flash[:success] = t "categories.success"
      redirect_to root_path
    else
      render :new
    end    
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end
end
