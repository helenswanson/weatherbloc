class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string    :title,           null: false
      t.text      :description,     null: false
      t.integer   :available_seats, null: false
      t.datetime  :start_time,      null: false
      t.datetime  :end_time,        null: false
      t.integer   :host_id,         null: false

      t.timestamps
    end
  end
end
