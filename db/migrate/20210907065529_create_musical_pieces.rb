class CreateMusicalPieces < ActiveRecord::Migration[5.2]
  def change
    create_table :musical_pieces do |t|
      t.string :name, null: false
      t.integer :year_of_composition
      t.integer :performance_time
      t.string :movie_reference_URL
      t.boolean :is_active, null: false , default: false

      t.timestamps
    end
  end
end
