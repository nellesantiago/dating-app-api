class Match < ApplicationRecord
  belongs_to :from, foreign_key: :from_user_id, class_name: "User"
  belongs_to :to, foreign_key: :to_user_id, class_name: "User"

  has_many :messages

  before_save :set_name

  enum status: { pending: 0, matched: 1 }

  def set_name
    self.name = "#{self.from.full_name}/#{self.to.full_name}"
  end

  def latest_message
    
  end
end
