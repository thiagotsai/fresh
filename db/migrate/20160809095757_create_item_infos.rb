class CreateItemInfos < ActiveRecord::Migration
  def change
    create_table :item_infos do |t|
      t.references :item, index: true, foreign_key: true
      t.references :ingredient, index: true, foreign_key: true
      t.string :preparation

      t.timestamps null: false
    end
  end
end
