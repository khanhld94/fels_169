class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.all_activity(current_user.id)
      .order created_at: :desc
  end
end
