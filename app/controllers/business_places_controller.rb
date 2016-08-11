class BusinessPlacesController < ApplicationController
  before_action :set_business_place, only: [:show, :edit, :update, :destroy, :map]
  skip_before_action :authenticate_user!, only: [:index, :show, :map]

  def index
    @business_places = BusinessPlace.all
  end

  def new
    @business_place = BusinessPlace.new
  end

  def show
  end

  def create
    @business_place = BusinessPlace.new(business_place_params)
    if @business_place.save
      redirect_to business_place_path(@business_place)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @business_place.update(business_place_params)
      redirect_to business_place_path(@business_place)
    else
      render :edit
    end
  end

  def destroy
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
                   :latitude, :longitude, :description)
  end

  def set_business_place
    @business_place = BusinessPlace.find(params[:id])
  end
end
