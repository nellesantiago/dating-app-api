module Mutations
  class LikeBack < BaseMutation
    # TODO: define return fields
    field :match, Types::MatchType, null: false

    # TODO: define arguments
    argument :match_id, Integer, required: true

    # TODO: define resolve method
    def resolve(match_id:)
      authorize_user_request

      match = @user.likes_received.find(match_id)

      raise GraphQL::ExecutionError.new "Error liking user" unless match.update(status: "matched")

      {match: match}
    end
  end
end
