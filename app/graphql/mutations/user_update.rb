# frozen_string_literal: true

module Mutations
  class UserUpdate < BaseMutation
    description "Updates a user by id"

    field :user, Types::UserType, null: false

    argument :user_input, Types::UserInputType, required: true
    argument :user_id, Integer, required: false

    def resolve(user_input:, user_id: nil)
      authorize_user_or_admin_request
      inputs = user_input.to_h

      if user_id && @user.admin?
        @user = resolve_user_by_id(user_id)
      end

      attachment_count = @user.image.count + inputs[:image].count
      raise GraphQL::ExecutionError.new "Image attachment count must not exceed to 5", extensions: @user.errors.to_hash unless attachment_count <= 5

      if @user.update(inputs.except(:image, :id))
        @user.image.attach(inputs[:image]) if inputs[:image]
      else
        raise GraphQL::ExecutionError.new "Error updating user", extensions: @user.errors.to_hash
      end

      { user: @user }
    end
  end
end
