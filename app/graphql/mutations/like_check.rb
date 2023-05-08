module Mutations
  class LikeCheck < BaseMutation
    # TODO: define return fields
    field :status, Boolean, null: false

    # TODO: define arguments
    argument :id, Integer, required: true

    # TODO: define resolve method
    def resolve(id:)
      authorize_user_request
      user = resolve_user_by_id(id)
      status = user.liked_user_ids.include?(@user.id)

      { status: status }
    end
  end
end
