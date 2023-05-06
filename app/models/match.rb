class Match < ApplicationRecord 
    belongs_to :from, foreign_key: :from_user_id, class_name: "User"
    belongs_to :to, foreign_key: :to_user_id, class_name: "User"

    enum status: { pending: 0, matched: 1 }
end
