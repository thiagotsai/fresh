class CreateBusinessPlaces < ActiveRecord::Migration
  def change
    create_table :business_places do |t|
      t.string :address
      t.references :city, index: true, foreign_key: true
      t.string :post_code
      t.string :status
      t.string :name
      t.string :opening_time
      t.string :cover_photo
      t.string :average_cost
      t.string :phone_number
      t.float :lat
      t.float :lon
      t.string :from_status

      t.timestamps null: false
    end
  end
end
