module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :all_users, resolver: Resolvers::UserResolver
    field :all_matches, resolver: Resolvers::MatchResolver
    field :all_messages, resolver: Resolvers::MessageResolver
  end
end
