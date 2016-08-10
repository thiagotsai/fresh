class RenameColumnsOnBusinessPlaces < ActiveRecord::Migration
  def change
    rename_column :business_places, :lat, :latitude
    rename_column :business_places, :lng, :longitude
    rename_column :users, :lat, :latitude
    rename_column :users, :lng, :longitude
  end
end
