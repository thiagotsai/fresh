class RenameFormStatusOnBusinessPlaces < ActiveRecord::Migration
  def change
    rename_column :business_places, :from_status, :form_status
  end
end
