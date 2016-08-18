class AddDishToItems < ActiveRecord::Migration
  def change
    add_reference :items, :dish, index: true, foreign_key: true
  end
end
