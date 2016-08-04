class LessonsController < ApplicationController
  load_and_authorize_resource only: [:create, :show]
  
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

  def lesson_params
    params.require(:lesson).permit :content, :category_id, 
      results_attributes: :word_answer_id
  end
end
