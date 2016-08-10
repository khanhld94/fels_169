class StaticPagesController < ApplicationController
  
  def home
    @lessons = current_user.lessons.includes(:results)
      .order(created_at: :desc).page params[:page]
    @activities = PublicActivity::Activity.all_activity(current_user.id)
      .order(created_at: :desc).page params[:page]
  end

  def about
  end
end
