class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
  rescue_from ActiveRecord::RecordNotFound do
    flash[:danger] = t "flash.record_not_found", column_name: params[:id]
    redirect_to root_url
  end

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up do |user_params|
      user_params.permit :email, :name, :password, :password_confirmation,
        :avatar, :avatar_cache
    end
    devise_parameter_sanitizer.permit :account_update do |user_params|
      user_params.permit :email, :name, :password, :password_confirmation,
        :current_password, :avatar, :avatar_cache, :remove_avatar
    end
  end

  def current_ability
    namespace = controller_path.split("/").first
    Ability.new current_user, namespace
  end

end
