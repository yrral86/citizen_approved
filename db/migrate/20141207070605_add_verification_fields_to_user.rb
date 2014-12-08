class AddVerificationFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :address, :string, null: false
    add_column :users, :address2, :string
    add_column :users, :city, :string, null: false
    add_column :users, :state_code, :string, null: false
    add_column :users, :zip, :string, null: false
    add_column :users, :verified, :boolean, null: false, default: false
  end
end
