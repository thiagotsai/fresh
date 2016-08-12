class RemoveMenuColumnFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :menu_id, :integer
  end
end
