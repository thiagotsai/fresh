class AddColumnsToItems < ActiveRecord::Migration
  def change
    add_column :items, :start_datetime, :datetime
    add_column :items, :end_datetime, :datetime
    add_reference :items, :business_place, index:true, foreign_key: true
  end
end
