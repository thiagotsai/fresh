class AddColumnsToBusinessPlaces < ActiveRecord::Migration
  def change
    add_column :business_places, :city, :string
    add_column :business_places, :country, :string
  end
end
