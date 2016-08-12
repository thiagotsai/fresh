class BusinessPlacesController < ApplicationController
  before_action :set_business_place, only: [:show, :edit, :update, :destroy, :map]
  skip_before_action :authenticate_user!, only: [:index, :show, :map]

  def index
    @business_places = BusinessPlace.all
  end

  def new
    @business_place = BusinessPlace.new
    @cuisines = Cuisine.all
  end

  def show
    @items = @business_place.items
  end

  def create
    @business_place = BusinessPlace.new(business_place_params)
    @business_place.current_user = current_user
    # "cuisines"=>"2", "cuisine_ids"=>["1", "3", ""]}
    @business_place.cuisine = Cuisine.find(params[:business_place][:cuisines])
    if @business_place.save
      redirect_to business_place_path(@business_place)
    else
      render :new
    end
  end

  def edit
    redirect_unauthorized_user
  end

  def update
    redirect_unauthorized_user

    if @business_place.update(business_place_params)
      redirect_to business_place_path(@business_place)
    else
      render :edit
    end
  end

  def destroy
    redirect_unauthorized_user

    @business_place.destroy
    flash[:success] = "Business place deleted"
    redirect_to business_places_path
  end

  def map
  end

  private

  def business_place_params
    params.require(:business_place).permit(:address, :city, :country, :zip_code,
                   :name, :opening_time, :cover_photo, :average_cost, :phone_number,
                   :latitude, :longitude, :description, cuisine_ids: [])
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
