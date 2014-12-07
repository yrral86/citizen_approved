class AddCurrentToBills < ActiveRecord::Migration
  def change
    add_column :bills, :current, :boolean, :default => false
  end
end
