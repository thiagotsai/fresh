class DishesController < ApplicationController
  layout :resolve_layout

  before_action :set_dish, only: [:edit, :update, :destroy]

  def edit
    @business_place = BusinessPlace.find(params[:business_place_id])
    redirect_unauthorized_user
    @dish = Dish.find(params[:id])
  end

  def update
    @business_place = BusinessPlace.find(params[:business_place_id])

    redirect_unauthorized_user

    if @dish.update(dish_params)
      respond_to do |format|
        format.html { redirect_to business_place_path(@business_place) }
        format.js  { render :edit }
      end
    else
      respond_to do |format|
        format.html { redirect_to business_place_path(@business_place) }
        format.js  { render :edit }
      end
    end
  end

  def destroy
    redirect_unauthorized_user

    @dish.destroy
    flash[:success] = "Dish deleted"
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end
  end

  private

  def dish_params
    params.require(:dish).permit(:name, :price, :description, :photo, :photo_cache)
  end

  def redirect_unauthorized_user
    #@business_place.users.include?(current_user)
    unless current_user.business_places.include?(@business_place)
      flash[:alert] = "You don't have access change to this Business Place"
      redirect_to business_place_path(@business_place)
    end
  end

  def set_dish
    @dish = Dish.find(params[:id])
  end

  def resolve_layout
    case action_name
    when "edit"
      "modal"
    else
      "application"
    end
  end
end
