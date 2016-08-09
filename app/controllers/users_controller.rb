class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :load_activities, only: :show

  def index
    @users = @users.student.page params[:page]
  end

  def show
    @relationship = if current_user.following? @user
      current_user.active_relationships.find_by followed_id: @user.id
    else
      current_user.active_relationships.build
    end
  end

  private
  def load_activities
    @activities = PublicActivity::Activity.all_activity(@user.id)
      .order(created_at: :desc).limit Settings.per_page
  end
end
