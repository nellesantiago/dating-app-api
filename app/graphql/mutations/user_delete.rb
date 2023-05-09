# frozen_string_literal: true

module Mutations
  class UserDelete < BaseMutation
    description "Deletes a user by ID"

    field :user, Types::UserType

    argument :user_input, Types::UserInputType, required: true

    def resolve(user_input:)
      authorize_user_or_admin_request

      user = resolve_user_by_id(user_input[:id])

      if user == @user || @user.admin?
        user.destroy
      else
        raise GraphQL::ExecutionError.new "Error deleting user"
      end

      { user: user }
    end
  end
end
