class CatsController < ApplicationController
  before_action :set_cat, only: [:show, :edit, :update, :destroy]
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
    @cats = Cat.search(params[:search])
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
        format.html { render :new }
        format.json { render json: @cat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cats/1
  # PATCH/PUT /cats/1.json
  def update
    respond_to do |format|
      if @cat.update(cat_params)
        format.html { redirect_to @cat, notice: 'Cat was successfully updated.' }
        format.json { render :show, status: :ok, location: @cat }
      else
        format.html { render :edit }
        format.json { render json: @cat.errors, status: :unprocessable_entity }
      end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cat
      @cat = Cat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cat_params
      params.require(:cat).permit(:user_id, :cat_type_id, :location_id, :name, :age, :color, :hyperactivity, :health, :about)
    end
end
