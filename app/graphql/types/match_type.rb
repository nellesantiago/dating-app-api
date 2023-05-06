# frozen_string_literal: true

module Types
  class MatchType < Types::BaseObject
    field :id, ID, null: false
    field :from, Types::UserType, null: false
    field :to, Types::UserType, null: false
    field :status, StatusType, null: false
    field :users, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def users
      [object.to.id, object.from.id]
    end
  end
end
