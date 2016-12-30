require 'will_paginate/array'

class CatsController < ApplicationController
  before_action :set_cat, only: [:show, :edit, :update, :destroy, :like]
  before_action :authenticate_user!, except: [:show, :index]
  # GET /cats
  # GET /cats.json
  def index

    if current_user
      @cats = Cat.where.not(user_id: current_user.id)
                .paginate(page: params[:page], per_page:8)
    else
      @cats = Cat.all
    end
  end

  def search
    if current_user
      @cats = Cat.where.not(user_id: current_user.id).search(params[:search])
                .paginate(page: params[:page], per_page:8)
    end
  end

  def custom_search
    if current_user
      @cats = Cat.where.not(user_id: current_user.id).custom_search(
        params[:hyperactivity],
        params[:health],
        params[:location_search],
        params[:type_search],
        params[:gender_id]
        ).paginate(page: params[:page], per_page:8)
    end
    render :search
  end

  # GET /cats/1
  # GET /cats/1.json
  def show
  end

  # GET /cats/new
  def new
    @cat = Cat.new
    @locations = Location.all
    @cat_healths = Cat::CAT_HEALTHS_ARR
  end

  # GET /cats/1/edit
  def edit

    @cat_healths = Cat::CAT_HEALTHS_ARR
  end

  # POST /cats
  # POST /cats.json
  def create
    @cat = Cat.new(cat_params)
    @cat.user = current_user
    respond_to do |format|
      if @cat.save
        format.html { redirect_to @cat, notice: 'Cat was successfully created.' }
        format.json { render :show, status: :created, location: @cat }
      else
        format.html { redirect_to new_cat_path }
        format.json { render json: @cat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cats/1
  # PATCH/PUT /cats/1.json
  def update
    if @cat.update(cat_params)
      redirect_to @cat, notice: 'Cat was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /cats/1
  # DELETE /cats/1.json
  def destroy
    @cat.destroy
    respond_to do |format|
      format.html { redirect_to cats_url, notice: 'Cat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # def like
  #   @cat
  #   #old cat  liked
  #   @new_cat = Cat.where('id > ?', @cat.id).first
  #   render :cat
  # end
  #
  # def dislike
  #   puts params[:current_cat]
  #   @cat = Cat.all[params[:current_cat] + 1]
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cat
      @cat = Cat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cat_params
      params.require(:cat).permit(:user_id, :cat_type_id, :location_id, :name,
                                  :age, :color, :hyperactivity, :health, :about,
                                  :image, :gender)
    end
end
