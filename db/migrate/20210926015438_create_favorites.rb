class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :member_id
      t.integer :musical_piece_comment_id

      t.timestamps
    end
  end
end
