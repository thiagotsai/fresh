class BusinessPlacesController < ApplicationController
  before_action :set_business_place, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @business_places = BusinessPlace.all
  end

  def new
    @business_place = BusinessPlace.new
    @cuisines = Cuisine.all
  end

  def show
    # Find only the dishes of today to show
    @items = @business_place.items.where('start_datetime >= :start AND end_datetime <= :end', start: Date.today, end: Date.today + 1)


    # Prepare previous dishes for the modal new item view
    @dishes = @business_place.dishes.where(status: "active")

    # Prepare for edit dish modal form
    @dish = @business_place.dishes.new

    # This logic is because we don't have a Dishes Table
    # distinct_names = Item.where(business_place_id: @business_place.id).distinct.pluck(:name)
    # @previous_items = []
    # distinct_names.each do |n|
    #   @previous_items << @business_place.items.find_by_name(n)
    # end

    # This is for the Edit Business Place to show combo-box of Cuisines
    @cuisines = Cuisine.all

    # Prepare to show the modal simple form for of the New Dish
    @item = Item.new
    @item.business_place = @business_place
  end

  def create
    @business_place = BusinessPlace.new(business_place_params)
    @business_place.current_user = current_user
    # "cuisines"=>"2", "cuisine_ids"=>["1", "3", ""]}
    # params { business_place: { address: "", cuisines: "2", cuisine_ids }}
    # @business_place.cuisine = Cuisine.find(params[:business_place][:cuisines])
    if @business_place.save
      redirect_to business_place_path(@business_place)
    else
      render :new
    end
  end

  def edit
    redirect_unauthorized_user
    @cuisines = Cuisine.all
    # @cuisine_id = 1
    # unless @business_place.business_cuisines.where(main: true).empty?
    #   @cuisine_id = @business_place.business_cuisines.where(main: true).first.cuisine_id
    # end

  end

  def update
    redirect_unauthorized_user
    #@business_place.cuisine = Cuisine.find(params[:business_place][:cuisines])
    if @business_place.update(business_place_params)
      redirect_to business_place_path(@business_place)
    else
      render :edit
    end
  end

  def owned
    @business_places = current_user.business_places
  end

  def destroy
    redirect_unauthorized_user

    @business_place.destroy
    flash[:success] = "Business place deleted"
    redirect_to request.referer
  end

  private

  def business_place_params
    params.require(:business_place).permit(:address, :city, :country, :zip_code,
                   :name, :opening_time, :cover_photo, :average_cost, :phone_number,
                   :latitude, :longitude, :description, :cuisine_id, cuisine_ids: [])
  end

  def set_business_place
    @business_place = BusinessPlace.find(params[:id])
  end

  def redirect_unauthorized_user
    unless current_user.business_places.include?(@business_place)
      flash[:alert] = "You don't have access change to this Business Place"
      redirect_to business_place_path(@business_place)
    end
  end
end
