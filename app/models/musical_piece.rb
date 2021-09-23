class MusicalPiece < ApplicationRecord
  belongs_to :composer
  has_many :musical_piece_comments, dependent: :destroy
  has_many :musical_piece_lists
  has_many :lists, through: :musical_piece_lists
  validates :musical_piece_name, presence: true, length: { maximum: 30 }
end
