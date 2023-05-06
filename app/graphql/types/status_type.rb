# frozen_string_literal: true

module Types
  class StatusType < Types::BaseEnum
    description "Status enum"
    value "pending"
    value "matched"
  end
end
