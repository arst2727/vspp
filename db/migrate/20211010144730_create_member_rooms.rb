class CreateMemberRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :member_rooms do |t|
      t.references :member
      t.references :room
      t.timestamps
    end
  end
end
