# frozen_string_literal: true

module Types
  class MatchType < Types::BaseObject
    field :id, ID, null: false
    field :from, Types::UserType, null: false
    field :to, Types::UserType, null: false
    field :status, StatusType, null: false
    field :latest_message, Types::MessageType
    field :messages, [Types::MessageType]
    field :name, String, null: false
    field :users, [Types::UserType]
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def latest_message
      if object.messages.any?
        object.messages.latest
      end
    end

    def users
      [object.from, object.to]
    end
  end
end
