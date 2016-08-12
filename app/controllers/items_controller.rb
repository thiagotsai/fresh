class ItemsController < ApplicationController
   #before_action :set_item, only: [:edit, :update, :destroy]

  def search
    @items = []
    BusinessPlace.near(params[:location]).each do |bp|
      @items += bp.items.where("description LIKE ? OR name LIKE ?", params[:query])
    end
  end



  def new
    @business_place = BusinessPlace.find(params[:business_place_id])
    @item = @business_place.items.new
  end

  def create
    @business_place = BusinessPlace.find(params[:business_place_id])
    @item = @business_place.items.new(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def edit
    @business_place = BusinessPlace.find(params[:business_place_id])
    @item = Item.find(params[:id])
  end

  def update
    @business_place = BusinessPlace.find(params[:business_place_id])
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:success] = "Item deleted"
    redirect_to request.referer
  end

  private

  def item_params
    params.require(:item).permit(:ready_at, :available_qty, :photo,
                   :name, :price, :currency, :description)
  end

  # def set_item
  #   @item = Item.find(params[:id])
  # end
end
