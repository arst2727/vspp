class CreateComposers < ActiveRecord::Migration[5.2]
  def change
    create_table :composers do |t|
      t.string :name_kana, null: false
      t.string :name_lang_en
      t.integer :year_of_birth
      t.integer :year_of_death
      t.string :reference_url
      t.boolean :is_active, null: false , default: false
      # 作曲家画像用
      t.string :avatar

      t.timestamps
    end
  end
end
