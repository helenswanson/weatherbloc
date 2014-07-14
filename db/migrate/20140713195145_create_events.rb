class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string  :title,           null: false
      t.string  :category1,       null: false
      t.string  :category2
      t.string  :description,     null: false
      t.integer :available_seats, null: false
      t.time    :start_time,      null: false
      t.time    :end_time,        null: false

      t.timestamps
    end
  end
end
