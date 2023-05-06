module Resolvers
    class MatchResolver < Resolvers::Base
      scope { Match.all }
  
      type [Types::MatchType], null: false
  
      option :where, type: Types::MatchFilterInputType, with: :apply_filter
    end
  end
  