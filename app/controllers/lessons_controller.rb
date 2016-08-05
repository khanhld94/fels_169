class LessonsController < ApplicationController
  load_and_authorize_resource only: [:create, :show, :update]
  before_action :load_results, only: :show
  
  def create
    @category = @lesson.category
    @lesson.user = current_user
    if @lesson.save
      redirect_to [@category, @lesson]
    else
      flash[:danger] = t :danger
      redirect_to categories_path
    end
  end

  def show  
  end
  
  def update
    @category = @lesson.category
    if @lesson.update_attributes lesson_params
      redirect_to [@category, @lesson]
    else
      flash[:danger] = t "flash.fail"
      redirect_to root_path
    end
  end
  
  private 
  def lesson_params
    params.require(:lesson).permit :content, :status, :category_id, 
      results_attributes: [:id, :word_answer_id]
  end

  def load_results
    @sum_correct_answer = @lesson.load_answer_correct
  end
end
