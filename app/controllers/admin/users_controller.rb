class Admin::UsersController < Admin::BaseController
  load_and_authorize_resource

  def index
    @search = @users.search params[:q]
    @users = @search.result.page params[:page]
  end

  def show
    @activities = PublicActivity::Activity.all_activity(@user.id)
      .order(created_at: :desc).limit Settings.per_page
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.delete_s"
    else
      flash[:danger] = t "users.delete_f"
    end
    redirect_to admin_users_path
  end
end
