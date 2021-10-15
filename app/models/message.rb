class Message < ApplicationRecord
  validates :message, presence: :true, length: { maximum: 140 }
  belongs_to :member
  belongs_to :room
  has_many :notifications, dependent: :destroy
end
