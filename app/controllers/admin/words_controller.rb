class Admin::WordsController < ApplicationController
  load_and_authorize_resource

  def new
    @categories = Category.all
    Settings.default_number_of_answers.times do
      @word.word_answers.build
    end
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
    params.require(:word).permit :content, :category_id,
      word_answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
end
