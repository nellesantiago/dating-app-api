module Resolvers
  class UserResolver < Resolvers::Base
    scope { User.all }

    type [Types::UserType], null: false

    option :where, type: Types::UserFilterInputType, with: :apply_filter
    option :first, type: Integer, with: :apply_first
    option :skip, type: Integer, with: :apply_skip
  
    def apply_first(scope, value)
      scope.first(value)
    end
  
    def apply_skip(scope, value)
      scope.drop(value)
    end
  end
end
