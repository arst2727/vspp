class Favorite < ApplicationRecord
  belongs_to :member
  belongs_to :musical_piece_comment
end
