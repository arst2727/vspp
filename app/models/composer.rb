class Composer < ApplicationRecord
  has_many :musical_pieces, dependent: :destroy

  # 同じ名前の作曲家を重複して新規登録できないようにする
  validates :name_kana, :name_lang_en, uniqueness: true, presence: true
  # 作曲家画像用
  has_one_attached :image
end
