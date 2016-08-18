class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :description
      t.string :photo
      t.decimal :price
      t.references :business_place, index: true, foreign_key: true
      t.string :status

      t.timestamps null: false
    end
  end
end
