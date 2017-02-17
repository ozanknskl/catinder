class HomeController < ApplicationController
  before_action :authenticate_user!, only: :mycats

  def index
  end

  def about
  end

  def mycats
    @cats = current_user.cats.paginate(page: params[:page], per_page:8)
  end


  def favourites
    @cats_array = []
    current_user.likes.each do |like|
      if like.status
        @cats_array.push(Cat.find(like.cat_id))
      end
    end
    @cats = @cats_array.paginate(page: params[:page], per_page:8)
    # render :mycats
  end


  def profile
    @user = current_user
  end
end
