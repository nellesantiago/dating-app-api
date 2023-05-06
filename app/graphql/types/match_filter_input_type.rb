# frozen_string_literal: true

module Types
  class MatchFilterInputType < Types::BaseInputObject
    argument :OR, [self], required: false   
    argument :id, Integer, required: false
    argument :from_user_id, Integer, required: false
    argument :to_user_id, Integer, required: false
    argument :status, Integer, required: false
  end
end
