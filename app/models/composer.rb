class Composer < ApplicationRecord
  has_many :musical_pieces, dependent: :destroy
end
