class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.integer :member_id
      t.string :name, null: false

      t.timestamps
    end
  end
end
