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
    devise_parameter_sanitizer.permit :sign_up, keys: [:username]
  end

  def current_ability
    namespace = controller_path.split("/").first
    Ability.new current_user, namespace
  end

end
