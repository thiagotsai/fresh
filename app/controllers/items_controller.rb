class ItemsController < ApplicationController
   before_action :set_item, only: [:edit, :update, :destroy]
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
        @items += bp.items.where("start_datetime >= :start AND end_datetime <= :end AND (lower(description) LIKE :query OR lower(name) LIKE :query)", query: "%#{params[:query]}%", start: Date.today, end: Date.today + 1).flatten
      end
    else
      # Filter only Business Places with the cuisine selected
      BusinessPlace.where(cuisine_id: @cuisine_id).near(@city).each do |bp|
        @items += bp.items.where("start_datetime >= :start AND end_datetime <= :end AND (lower(description) LIKE :query OR lower(name) LIKE :query)", query: "%#{params[:query]}%", start: Date.today, end: Date.today + 1).flatten
        # bp.cuisines.where(name: params[:cuisines].each do
      end
    end

    #Calculate distance of user from each business_place
    if session[:lat] && session[:lng]
      @items.each do |item|
        if item.business_place.geocoded?
          item.distance = item.business_place.distance_from([session[:lat],session[:lng]])
          item.walking_time = item.distance / 0.08 #Walking pace is 5km/h or 0.08km/min
        end
      end
    end

    if @sort == 0 #Name
      @items.sort! { |a,b| a.distance <=> b.distance }
    elsif @sort == 1 #Name
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

    # Redirect user if he does not have access to the business place
    redirect_unauthorized_user

    # Create a new Item
    @item = @business_place.items.new(item_params)
    @item.start_datetime ||= Date.today
    @item.end_datetime ||= Date.today + 1
    @item.user = current_user

    #Check is Dish does not exist by name, then create a new one
    @dish = Dish.find_by_name(@item.name)

    # If dish not found, create it
    unless @dish
      #Create a new dish
      @dish = Dish.new(dish_params)
      @dish.business_place = @business_place
      @dish.status = "active"
      @dish.save
    end

    # Link the dish to the new item
    @item.dish = @dish

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
    dish = Dish.find(params[:dish_id])

    # Create a new item based on the dish
    @item = Item.new(name: dish.name, description: dish.description,
                     price: dish.price,
                     business_place: dish.business_place,
                     dish: dish, user: current_user)

    # To save the remote url of the photo you need to do this
    @item.remote_photo_url = dish.photo_url
    @item.start_datetime = Date.today
    @item.end_datetime = Date.today + 1

    if @item.save
      # Variable to use in view for the ajax js
      # to send the item_show with close button
      @close_button = true

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
      #Find the dish related to the item and also update it
      if @item.dish
        @item.dish.update(dish_params)
      end
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

  def dish_params
    params.require(:item).permit(:photo, :name, :price, :description)
  end

  def redirect_unauthorized_user
    #@business_place.users.include?(current_user)
    unless current_user.business_places.include?(@business_place)
      flash[:alert] = "You don't have access change to this Business Place"
      redirect_to business_place_path(@business_place)
    end
  end

  def set_item
   @item = Item.find(params[:id])
  end
end
