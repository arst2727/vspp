class CreateMusicalPieces < ActiveRecord::Migration[5.2]
  def change
    create_table :musical_pieces do |t|
      t.integer :composer_id
      t.string :composer_name
      t.string :musical_piece_name, null: false
      t.integer :year_of_composition
      t.integer :performance_time
      t.string :reference_URL
      t.boolean :is_active, null: false , default: false

      t.timestamps
    end
  end
end
