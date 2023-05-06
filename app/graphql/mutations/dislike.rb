module Mutations
  class Dislike < BaseMutation
    field :blacklist, Types::BlacklistType, null: false

    argument :user_id, Integer, required: true

    def resolve(user_id:)
      authorize_user_request

      blacklist = @user.blocks_given.build(blocked_id: user_id)
      match = @user.likes_received.find_by(from_user_id: user_id)

      unless match && match.destroy || blacklist.save
        raise GraphQL::ExecutionError.new "Error blocking user"
      end

      { blacklist: blacklist }
    end
  end
end
