class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :member_rooms, dependent: :destroy
  has_many :members, through: :member_rooms
end
