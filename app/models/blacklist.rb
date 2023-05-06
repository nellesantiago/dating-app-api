class Blacklist < ApplicationRecord
    belongs_to :blocked_by, foreign_key: :blocked_by_id, class_name: "User"
    belongs_to :blocked, foreign_key: :blocked_id, class_name: "User"
end
