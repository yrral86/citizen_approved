class AddFieldsToBills < ActiveRecord::Migration
  def change
    add_column :bills, :govtrack_id, :integer
    add_column :bills, :govtrack_url, :string
    add_column :bills, :thomas_url, :string
    add_column :bills, :congress, :integer
    add_column :bills, :summary, :text

    add_index :bills, :govtrack_id, unique:true
  end
end
