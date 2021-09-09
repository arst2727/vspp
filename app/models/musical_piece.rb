class MusicalPiece < ApplicationRecord
  belongs_to :composer
  has_many :musical_piece_comments, dependent: :destroy
end
