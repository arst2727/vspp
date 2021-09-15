class MusicalPieceList < ApplicationRecord
  belongs_to :musical_piece
  belongs_to :list, touch: true
  validates :list_id, uniqueness: { scope: :musical_piece_id }
end
