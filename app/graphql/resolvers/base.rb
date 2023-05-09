require "search_object"
require "search_object/plugin/graphql"

module Resolvers
  class Base < GraphQL::Schema::Resolver
    include SearchObject.module(:graphql)

    def apply_filter(scope, value)
      token = context[:headers]["token"]

      validate_token(token)

      branches = normalize_filters(scope, value).reduce { |a, b| a.or(b) }
      scope.merge branches
    end

    def normalize_filters(scope, values, branches = [])
      @scope = scope
      values.each do |key, v|
        unless key == :OR || key == :gender_interests || key == :id_filter || key == :matched_with_id
          if v.instance_of?(String)
            @scope = @scope.where("#{key} ILIKE ?", "%#{v.downcase}%")
          else
            @scope = @scope.where("#{key} = ?", v)
          end
        end

        if key == :gender_interests
          @scope = @scope.select { |user| user.gender_interests.include?(v) }
        end

        if key == :id_filter
          @scope = @scope.select { |user| User.find(v).liked_user_ids.exclude?(user.id) && user.id != v }
          @scope = @scope.select { |user| User.find(v).gender_interests.include?(resolve_interest(user.gender)) }
          @scope = @scope.select { |user| user.matches.exclude?(v) }
          @scope = @scope.select { |user| user.blocked_by_user_ids.exclude?(v) }
          @scope = @scope.select { |user| user.blocked_users.exclude?(v) }
        end

        if key == :matched_with_id
          @scope = @scope.select { |user| user.matches.include?(v) }
        end
      end

      branches << @scope

      values[:OR].reduce(branches) { |s, v| normalize_filters(scope, v, s) } if values[:OR].present?

      branches
    end

    def validate_token(token)
      decode_token(token)

      @user = User.find(@token["user_id"])
      return raise GraphQL::ExecutionError.new "Token is invalid" unless @user
    end

    def decode_token(token)
      begin
        @token = JsonWebToken.decode(token)
      rescue JWT::DecodeError
        return raise GraphQL::ExecutionError.new "Token is invalid"
      end
    end

    def resolve_interest(gender)
      case gender
      when "man"
        "men"
      when "woman"
        "women"
      when "nonbinary"
        "nonbinary_people"
      else
        "Error"
      end
    end
  end
end
