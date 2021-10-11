class Message < ApplicationRecord
  validates :message, presence: :true
  belongs_to :member
  belongs_to :room
end
