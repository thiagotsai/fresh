class AddMainCuisineToBusinessPlaces < ActiveRecord::Migration
  def change
    add_reference :business_places, :cuisine, index:true, foreign_key: true
  end
end
