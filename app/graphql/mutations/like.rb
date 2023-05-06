module Mutations
  class Like < BaseMutation
    field :match, Types::MatchType, null: false

    argument :user_id, Integer, required: true

    def resolve(user_id:)
      authorize_user_request

      match = @user.likes_given.build(to_user_id: user_id)

      raise GraphQL::ExecutionError.new "Error liking user" unless match.save

      { match: match }
    end
  end
end
