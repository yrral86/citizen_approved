class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :house_district_id, :integer
    add_column :users, :senate_district_id, :integer
    add_column :users, :voter_id, :string
    add_index :users, :house_district_id
    add_index :users, :senate_district_id
  end
end
