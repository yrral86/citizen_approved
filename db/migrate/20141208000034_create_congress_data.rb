class CreateCongressData < ActiveRecord::Migration
  def change
    create_table :congress_data do |t|
      t.integer :congress
      t.integer :proposed
      t.integer :enacted

      t.timestamps null: false
    end
  end
end
