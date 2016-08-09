class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :menu, index: true, foreign_key: true
      t.string :name
      t.datetime :ready_at
      t.decimal :available_qty
      t.references :user, index: true, foreign_key: true
      t.string :photo
      t.string :description
      t.decimal :price
      t.string :currency

      t.timestamps null: false
    end
  end
end
