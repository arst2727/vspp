class CreateMusicalPieceLists < ActiveRecord::Migration[5.2]
  def change
    create_table :musical_piece_lists do |t|
      t.references :musical_piece, index: true
      t.references :list, index: true

      t.timestamps
    end
  end
end
