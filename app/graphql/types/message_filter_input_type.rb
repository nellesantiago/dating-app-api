# frozen_string_literal: true

module Types
  class MessageFilterInputType < Types::BaseInputObject
    argument :OR, [self], required: false   
    argument :id, Integer, required: false
    argument :user_id, Integer, required: false
    argument :match_id, Integer, required: false
  end
end
