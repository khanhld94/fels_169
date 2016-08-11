class StaticPagesController < ApplicationController
  before_action :verify_admin
  
  def home
    @lessons = current_user.lessons.includes(:results)
      .order(created_at: :desc).page params[:page]
    @activities = PublicActivity::Activity.all_activity(current_user.id)
      .order(created_at: :desc).page params[:page]
  end

  def about
  end

  private
  def verify_admin
    redirect_to admin_root_url if current_user.admin?
  end
end
