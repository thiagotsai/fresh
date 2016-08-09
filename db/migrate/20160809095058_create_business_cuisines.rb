class CreateBusinessCuisines < ActiveRecord::Migration
  def change
    create_table :business_cuisines do |t|
      t.references :business_place, index: true, foreign_key: true
      t.references :cuisine, index: true, foreign_key: true
      t.boolean :main

      t.timestamps null: false
    end
  end
end
