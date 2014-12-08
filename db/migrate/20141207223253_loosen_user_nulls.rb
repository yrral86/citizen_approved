class LoosenUserNulls < ActiveRecord::Migration
  def change
    change_column_null :users, :name, true
    change_column_null :users, :address, true
    change_column_null :users, :city, true
    change_column_null :users, :state_code, true
    change_column_null :users, :zip, true
  end
end
