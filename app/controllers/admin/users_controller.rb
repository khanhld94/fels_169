class Admin::UsersController < ApplicationController
  load_and_authorize_resource
  
  def index
    @search = @users.search params[:q]
    @users = @search.result.page(params[:page]).per Settings.per_page    
  end
end
