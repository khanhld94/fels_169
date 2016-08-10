class LessonsController < ApplicationController
  load_and_authorize_resource except: [:edit, :destroy]
  before_action :load_results, :load_info_lesson, only: :show
  
  def index
    @lessons = current_user.lessons
    @search = @lessons.search params[:q]
    @lessons = @search.result.page params[:page]
  end

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

  def load_info_lesson
    @time_lesson = Settings.time_lesson - (Time.now.to_i -
      @lesson.updated_at.to_time.to_i)
    if @time_lesson <= 0 or @lesson.finished?
      @time_lesson = 0
    end
    @count = 0
    @lesson.results.each do |result|
      if result.word_answer.present?
        @count = @count.next
      end
    end
  end
end
