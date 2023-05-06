# frozen_string_literal: true

module Types
  class BlacklistType < Types::BaseObject
    field :id, ID, null: false
    field :blocked_by, Types::UserType, null: false
    field :blocked, Types::UserType, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
