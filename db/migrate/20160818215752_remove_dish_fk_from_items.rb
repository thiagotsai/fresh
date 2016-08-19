class RemoveDishFkFromItems < ActiveRecord::Migration
  def change
    remove_foreign_key :items, column: :dish_id
  end
end
