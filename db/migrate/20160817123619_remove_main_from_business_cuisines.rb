class RemoveMainFromBusinessCuisines < ActiveRecord::Migration
  def change
    remove_column :business_cuisines, :main, :boolean
  end
end
