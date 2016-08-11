class MenusController < ApplicationController
  before_action :set_business_place, except: :destroy

  def new
    @menu = @business_place.menus.new
  end

  def create
    @menu = @business_place.menus.new(menu_params)
    if @menu.save
      redirect_to business_place_path(@business_place)
    else
      render :new
    end
  end

  def edit
    @menu = @business_place.menus.find(params[:id])
  end

  def update
    @menu = @business_place.menus.find(params[:id])
    if @menu.update(menu_params)
      redirect_to menu_path(@menu)
    else
      render :edit
    end
  end

  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy
    flash[:success] = "menu deleted"
    redirect_to request.referer
  end

  private

  def menu_params
    params.require(:menu).permit(:start_datetime, :end_datetime, :name) #Should the ids also be parameters?
  end

  def set_business_place
    @business_place = BusinessPlace.find(params[:business_place_id])
  end
end
