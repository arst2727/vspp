class List < ApplicationRecord
  belongs_to :member
  has_many :musical_pieces
  # リスト名は空を許さず10文字まで
  validates :name, presence: true, length: {maximum: 10}
end
