require "search_object"
require "search_object/plugin/graphql"

module Resolvers
  class Base < GraphQL::Schema::Resolver
    include SearchObject.module(:graphql)

    def apply_filter(scope, value)
    #   token = context[:headers]["token"]

    #   validate_token(token)

      branches = normalize_filters(scope, value).reduce { |a, b| a.or(b) }
      scope.merge branches
    end

    def normalize_filters(scope, values, branches = [])
      @scope = scope
      values.each do |key, v|
        unless key == :OR
          if v == v.to_i.to_s
            @scope = @scope.where("#{key} = ?", "#{v}")
          else
            @scope = @scope.where("#{key} ILIKE ?", "%#{v.downcase}%")
          end
        end
      end

      branches << @scope

      values[:OR].reduce(branches) { |s, v| normalize_filters(scope, v, s) } if values[:OR].present?

      branches
    end

    # def validate_token(token)
    #   decode_token(token)

    #   @user = User.find(@token["user_id"])
    #   return raise GraphQL::ExecutionError.new "Token is invalid" unless @user
    # end

    # def decode_token(token)
    #   begin
    #     @token = JsonWebToken.decode(token)
    #   rescue JWT::DecodeError
    #     return raise GraphQL::ExecutionError.new "Token is invalid"
    #   end
    # end
  end
end
