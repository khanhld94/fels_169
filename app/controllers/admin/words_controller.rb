class Admin::WordsController < ApplicationController
  load_and_authorize_resource
  before_action :load_categories, only: [:new, :edit]

  def index
    @search = @words.search params[:q]
    @words = @search.result.page params[:page]
  end

  def new
    Settings.default_number_of_answers.times do
      @word.word_answers.build
    end
  end

  def create
    if @word.save
      flash[:success] = t "words.success"
      redirect_to root_url
    else
      load_categories
      flash[:danger] = t "words.fail"
      render :new
    end
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "words.success"
      redirect_to root_url
    else
      load_categories
      flash[:danger] = t "words.fail"
      render :edit
    end      
  end

  def destroy
    if @word.destroy
      flash[:success] = t "words.success"
    else
      flash[:danger] = t "words.fail"
    end
    redirect_to admin_words_path
  end

  private
  def word_params
    params.require(:word).permit :content, :category_id,
      word_answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def load_categories
    @categories = Category.all
  end
end
