class UsersController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def show
    @relationship = if current_user.following? @user
      current_user.active_relationships.find_by followed_id: @user.id
    else
      current_user.active_relationships.build
    end
  end
end
