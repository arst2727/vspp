class List < ApplicationRecord
  belongs_to :member
  has_many :musical_piece_lists, dependent: :destroy
  has_many :musical_pieces, through: :musical_piece_lists
  accepts_nested_attributes_for :musical_piece_lists, allow_destroy: true
  # リスト名は空を許さず10文字まで
  validates :name, presence: true, length: {maximum: 10}
end
