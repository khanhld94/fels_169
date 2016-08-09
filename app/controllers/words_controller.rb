class WordsController < ApplicationController
  load_and_authorize_resource

  def index
    @categories = Category.all
    @words = if (params[:condition].nil? || params[:condition] == "all")
      @words
    else
      @words.send("#{params[:condition]}", current_user.id)
    end
    @search = @words.search params[:q]
    @words = @search.result.includes(:category).page params[:page]
  end

  def show
  end

end
