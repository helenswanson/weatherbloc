class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.integer :event_id, null: false
      t.integer :category_id, null: false

      t.timestamps
    end

    add_index :categorizations, [:event_id, :category_id], unique: true
  end
end
