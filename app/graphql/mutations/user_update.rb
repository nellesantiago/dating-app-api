# frozen_string_literal: true

module Mutations
  class UserUpdate < BaseMutation
    description "Updates a user by id"

    field :user, Types::UserType, null: false

    argument :user_input, Types::UserInputType, required: true
    argument :user_id, Integer, required: false

    def resolve(user_input:, user_id: nil)
      authorize_user_or_admin_request
      
      if user_id && @user.admin?
        @user = resolve_user_by_id(user_id)
      end 

      raise GraphQL::ExecutionError.new "Error updating user" unless @user.update(**user_input)

      { user: @user }
    end
  end
end
