class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :location
      t.float :pricing
      t.date :date
      t.text :schedule
      t.time :start_time
      t.integer :pax_slots

      t.timestamps null: false
    end
  end
end
