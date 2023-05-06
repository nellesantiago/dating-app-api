# frozen_string_literal: true

module Mutations
  class UserDelete < BaseMutation
    description "Deletes a user by ID"

    field :user, Types::UserType

    argument :user_input, Types::UserInputType, required: true

    def resolve(user_input:)
      token = context[:headers]["token"]
      user = resolve_user_by_id(user_input[:id])

      validate_correct_user_or_admin_token(user, token)

      raise GraphQL::ExecutionError.new "Error deleting user" unless user.destroy

      { user: user }
    end
  end
end
