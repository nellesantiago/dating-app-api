module Resolvers
    class MessageResolver < Resolvers::Base
      scope { Message.all }
  
      type [Types::MessageType], null: false
  
      option :where, type: Types::MessageFilterInputType, with: :apply_filter
    end
  end
  