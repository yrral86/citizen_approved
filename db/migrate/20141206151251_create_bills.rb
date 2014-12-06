class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :title
      t.string :overview
      t.string :full_text_url
      t.integer :number
      t.boolean :senate

      t.timestamps null: false
    end
  end
end
