class RelationshipsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @title = t "relationship.#{params[:action_type]}"
    @users = @user.send params[:action_type]
  end

  def create
    @user = User.find_by id: params[:followed_id]
    if @user.present?
      current_user.follow @user
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
      end
    else
      flash[:danger] = t "users.empty"
      redirect_to root_url
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow @user 
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
