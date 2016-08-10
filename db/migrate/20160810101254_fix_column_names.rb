class FixColumnNames < ActiveRecord::Migration
  def change
    rename_column :business_places, :post_code, :zip_code
    rename_column :business_places, :lon, :lng
    rename_column :users, :lon, :lng
  end
end
