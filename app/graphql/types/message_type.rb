# frozen_string_literal: true

module Types
  class MessageType < Types::BaseObject
    field :id, ID
    field :content, String
    field :match, Types::MatchType
    field :user, Types::UserType
    field :sender, String
    field :created_at, GraphQL::Types::ISO8601DateTime
    field :updated_at, GraphQL::Types::ISO8601DateTime

    def sender
      object.user.full_name
    end
  end
end
