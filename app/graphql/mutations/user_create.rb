# frozen_string_literal: true

module Mutations
  class UserCreate < BaseMutation
    description "Creates a new user"

    field :user, Types::UserType, null: false

    argument :user_input, Types::UserInputType, required: true
    argument :interests, String, required: true

    def resolve(user_input:, interests:)
      inputs = user_input.to_h

      user = ::User.new(inputs.except(:image))
      user.birthdate = Date.strptime(user_input[:birthdate], "%m/%d/%Y")

      unless inputs[:image] && inputs[:image].count > 0
        raise GraphQL::ExecutionError.new "At least one profile image is required", extensions: user.errors.to_hash
      end

      if user.save
        user.image.attach(inputs[:image]) if inputs[:image]
        interests.split("/").each do |interest|
          user.interests.create(gender: interest)
        end
      else
        raise GraphQL::ExecutionError.new "#{user.errors.full_messages[0]}", extensions: user.errors.to_hash
      end

      { user: user }
    end
  end
end
