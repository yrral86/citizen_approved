class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.boolean :senate
      t.string :state_code
      t.integer :number
      t.string :name

      t.timestamps null: false
    end
  end
end
