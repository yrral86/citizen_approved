class RemoveFieldsFromBills < ActiveRecord::Migration
  def change
    remove_column :bills, :overview
    remove_column :bills, :full_text_url
  end
end
