# frozen_string_literal: true

module Mutations
  class UserUpdate < BaseMutation
    description "Updates a user by id"

    field :user, Types::UserType, null: false

    argument :user_input, Types::UserInputType, required: true
    argument :user_id, Integer, required: false

    def resolve(user_input:, user_id: nil)
      token = context[:headers]["token"]
      uid = context[:headers]["uid"]
      user = resolve_user_by_id(uid)
      validate_correct_user_or_admin_token(user, token)
      
      if user_id && @user.admin?
        user = resolve_user_by_id(user_id)
      end 

      raise GraphQL::ExecutionError.new "#{user.errors.full_messages}" unless user.update(**user_input)

      { user: user }
    end
  end
end
