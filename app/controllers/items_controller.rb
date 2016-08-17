class ItemsController < ApplicationController
   #before_action :set_item, only: [:edit, :update, :destroy]
   skip_before_action :authenticate_user!, only: [:search]

  def search
    # Preparation to search view filters form
    default_city = request.location.city.blank? ? "lisboa" : request.location.city
    @city = (params[:location].nil? or params[:location].blank?) ? default_city : params[:location].downcase
    @city = "lisboa" if @city == "lisbon"
    @sort = (params[:sort].nil? or params[:sort].blank?) ? 0 : params[:sort].to_i
    @cuisine_id = params[:cuisine_id].to_i

    # Filter items to be listed
    @items = []

    if @cuisine_id == 0
      # Filter ignoring Cuisine
      BusinessPlace.near(@city).each do |bp|
        @items += bp.items.where("lower(description) LIKE ? OR lower(name) LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%").flatten
      end
    else
      # Filter only Business Places with the cuisine selected
      BusinessPlace.where(cuisine_id: @cuisine_id).near(@city).each do |bp|
        @items += bp.items.where("lower(description) LIKE ? OR lower(name) LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%").flatten
        # bp.cuisines.where(name: params[:cuisines].each do
      end
    end

    if @sort == 1 #Name
      @items.sort! { |a,b| a.name <=> b.name }
    elsif @sort == 2 #Low to High
      @items.sort! { |a,b| a.price <=> b.price }
    elsif @sort == 3
      @items.sort! { |a,b| b.price <=> a.price }
    else
      # TODO Distance!!!
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
    @item.start_datetime ||= Date.today
    @item.end_datetime ||= Date.today + 1
    if @item.save
      flash[:notice] = "New item sucessfully created!"
      respond_to do |format|
        format.html { redirect_to business_place_path(@business_place) }
        format.js  # <-- will render `app/views/items/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js # <-- will render `app/views/items/create.js.erb`
      end
    end
  end

  def copy
    copy_item = Item.find(params[:item_id])
    @item = copy_item.dup
    @item.start_datetime = Date.today
    @item.end_datetime = Date.today + 1
    @close_button = true
    if @item.save
      respond_to do |format|
        format.html { redirect_to business_place_path(@business_place) }
        format.js  { render :create }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.js  { render :create }
      end
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

    # Logic to remove the item if it was the last one using js
    # If can find one element then flag as last item
    unique_name = @item.name
    item = @business_place.items.find_by_name(unique_name)
    unless item.nil?
      @last_item = true
    end

    flash[:success] = "Item deleted"
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.js
    end

  end

  private

  def item_params
    params.require(:item).permit(:ready_at, :available_qty, :photo,
                   :name, :price, :currency, :description,
                   :start_datetime, :end_datetime, ingredient_ids: [])
  end

  def redirect_unauthorized_user
    #@business_place.users.include?(current_user)
    unless current_user.business_places.include?(@business_place)
      flash[:alert] = "You don't have access change to this Business Place"
      redirect_to business_place_path(@business_place)
    end
  end

  # def set_item
  #   @item = Item.find(params[:id])
  # end
end
