class DropCitiesTable < ActiveRecord::Migration
  def up
    drop_table :cities
    drop_table :states
    drop_table :countries
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
