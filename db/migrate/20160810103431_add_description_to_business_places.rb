class AddDescriptionToBusinessPlaces < ActiveRecord::Migration
  def change
    add_column :business_places, :description, :string
  end
end
