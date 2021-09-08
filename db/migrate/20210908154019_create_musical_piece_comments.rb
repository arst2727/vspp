class CreateMusicalPieceComments < ActiveRecord::Migration[5.2]
  def change
    create_table :musical_piece_comments do |t|
      t.integer :member_id
      t.integer :musical_piece_id
      t.string :comment

      t.timestamps
    end
  end
end
