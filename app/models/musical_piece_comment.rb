class MusicalPieceComment < ApplicationRecord
  belongs_to :musical_piece
  belongs_to :member
  validates :comment, presence: true, length: {maximum: 200}
end
