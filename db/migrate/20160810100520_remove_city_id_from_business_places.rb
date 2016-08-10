class RemoveCityIdFromBusinessPlaces < ActiveRecord::Migration
  def change
    remove_column :business_places, :city_id, :string
  end
end
