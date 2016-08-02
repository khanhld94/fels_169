class Admin::WordsController < ApplicationController
  load_and_authorize_resource

  def new
    @categories = Category.all
  end

  def create
    if @word.save
      flash[:success] = t "words.success"
      redirect_to root_url
    else
      flash[:danger] = t "words.fail"
      render :new
    end
  end

  private
  def word_params
    params.require(:word).permit :content, :category_id
  end
end
