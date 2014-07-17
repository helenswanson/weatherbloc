class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.integer :user_id, null: false
      t.integer :event_id, null: false

      t.timestamps
    end
  end
end
