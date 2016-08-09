class CreateBusinessPlaceUsers < ActiveRecord::Migration
  def change
    create_table :business_place_users do |t|
      t.references :business_place, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :main

      t.timestamps null: false
    end
  end
end
