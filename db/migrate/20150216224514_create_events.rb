class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :location
      t.datetime :date
      t.decimal :price
      t.integer :tickets
      t.text :categories
      t.text :transportation_details

      t.timestamps
    end
  end
end
