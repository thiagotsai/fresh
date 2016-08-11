class ChangeColumnMainOnBusinessCuisines < ActiveRecord::Migration
  def change
    change_column :business_cuisines, :main, :boolean, default: false, null: true
  end
end
