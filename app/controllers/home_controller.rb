class HomeController < ApplicationController
  before_action :authenticate_user!, only: :mycats

  def index
  end

  def about
  end

  def mycats
    @cats = current_user.cats
  end
end
