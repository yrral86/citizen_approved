class CreateCongresses < ActiveRecord::Migration
  def change
    create_table :congresses do |t|
      t.integer :number
      t.integer :session
      t.date :dstart
      t.date :dend
      t.boolean :current, default: false

      t.timestamps null: false
    end
  end
end
