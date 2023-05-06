# frozen_string_literal: true

module Mutations
  class MessageCreate < BaseMutation
    description "Creates a new message"

    field :message, Types::MessageType, null: false

    argument :message_input, Types::MessageInputType, required: true

    def resolve(message_input:)
      authorize_user_request

      message = @user.messages.build(**message_input)

      raise GraphQL::ExecutionError.new "Error creating message", extensions: message.errors.to_hash unless message.save

      { message: message }
    end
  end
end
