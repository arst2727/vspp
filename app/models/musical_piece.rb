class MusicalPiece < ApplicationRecord
  belongs_to :composer
  has_many :musical_piece_comment, dependent: :destroy
end
