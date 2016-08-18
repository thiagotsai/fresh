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
    @business_place = @dish.business_place
    redirect_unauthorized_user

    # Delete instead of destroy because we don't want
    # the callbacks to be called (we want items to still be available)
    # and not destroied together with the dish
    @dish.delete

    # Destroy also is there is any item in the day
    # with the destroied dish, get the ids in @today_destroied_items
    # to send in ajax and remove with animation
    @destroied_item_ids = @dish.business_place.today_items.where(dish: @dish).distinct.pluck(:id)
    @dish.business_place.today_items.where(dish: @dish).each do |i|
      i.destroy
    end

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
