class ItemsController < ApplicationController
   #before_action :set_item, only: [:edit, :update, :destroy]
   skip_before_action :authenticate_user!, only: [:search]

  def search
    @items = []
    BusinessPlace.near(params[:location]).each do |bp|
      @items += bp.items.where("lower(description) LIKE ? OR lower(name) LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%").flatten
    end
  end

  def new
    @business_place = BusinessPlace.find(params[:business_place_id])
    redirect_unauthorized_user
    @item = @business_place.items.new
  end

  def create
    @business_place = BusinessPlace.find(params[:business_place_id])

    redirect_unauthorized_user

    @item = @business_place.items.new(item_params)
    if @item.save
      redirect_to business_place_path(@business_place)
    else
      render :new
    end
  end

  def edit
    @business_place = BusinessPlace.find(params[:business_place_id])

    redirect_unauthorized_user

    @item = Item.find(params[:id])
  end

  def update
    @business_place = BusinessPlace.find(params[:business_place_id])

    redirect_unauthorized_user

    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to business_place_path(@business_place)
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @business_place = @item.business_place
    redirect_unauthorized_user

    @item.destroy
    flash[:success] = "Item deleted"
    redirect_to request.referer
  end

  private

  def item_params
    params.require(:item).permit(:ready_at, :available_qty, :photo,
                   :name, :price, :currency, :description,
                   :start_datetime, :end_datetime, ingredient_ids: [])
  end

  def redirect_unauthorized_user
    unless current_user.business_places.include?(@business_place)
      flash[:alert] = "You don't have access change to this Business Place"
      redirect_to business_place_path(@business_place)
    end
  end

  # def set_item
  #   @item = Item.find(params[:id])
  # end
end
