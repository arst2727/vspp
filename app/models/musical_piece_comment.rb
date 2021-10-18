class MusicalPieceComment < ApplicationRecord
  belongs_to :musical_piece
  belongs_to :member
  has_many :favorites, dependent: :destroy
  # コメントは空を許さず200文字まで
  validates :comment, presence: true, length: { maximum: 200 }
  # 1会員は1楽曲に対して1度しかコメント及び評価ができない
  validates :member_id, uniqueness: { scope: :musical_piece_id }
  validates :evaluation, presence: true, numericality: { greater_than: 0 }
  def favorited_by?(member)
    favorites.where(member_id: member.id).exists?
  end
end
