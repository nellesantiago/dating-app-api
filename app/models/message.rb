class Message < ApplicationRecord
  belongs_to :match
  belongs_to :user

  validates :content, presence: true, length: { in: 1..150 }

  scope :latest, -> {find_by(created_at: maximum(:created_at))}
end
