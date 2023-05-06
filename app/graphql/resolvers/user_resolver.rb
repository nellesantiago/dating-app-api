module Resolvers
  class UserResolver < Resolvers::Base
    scope { User.all }

    type [Types::UserType], null: false

    option :where, type: Types::UserFilterInputType, with: :apply_filter
  end
end
