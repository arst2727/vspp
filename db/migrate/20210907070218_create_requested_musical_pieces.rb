class CreateRequestedMusicalPieces < ActiveRecord::Migration[5.2]
  def change
    create_table :requested_musical_pieces do |t|
      t.string :composer_name
      t.string :musical_piece_name
      t.string :reference_url
      t.boolean :is_active, null: false , default: false

      t.timestamps
    end
  end
end
