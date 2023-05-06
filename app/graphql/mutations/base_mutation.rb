module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def check_user_credentials(email, password)
      @user = User.find_by(email: email)
      @authorized = @user && @user.authenticate(password)
      return raise GraphQL::ExecutionError.new("Invalid email or password") unless @authorized
    end

    def validate_correct_user_token(user, token)
      validate_token(token)

      @user = resolve_user_by_id(@token["user_id"])
      return raise GraphQL::ExecutionError.new "Token is invalid" unless @user && @user == user
    end

    def validate_correct_user_or_admin_token(user, token)
      validate_token(token)

      @user = resolve_user_by_id(@token["user_id"])

      return raise GraphQL::ExecutionError.new "Token is invalid" unless @user == user || @user.admin? && @user == user
    end

    def validate_admin_token(token)
      validate_token(token)
      
      @user = resolve_user_by_id(@token["user_id"])

      return raise GraphQL::ExecutionError.new "Token is invalid" unless @user.admin?
    end

    def validate_token(token)
      begin
        @token = JsonWebToken.decode(token)
      rescue JWT::DecodeError
        return raise GraphQL::ExecutionError.new "Token is invalid"
      end
    end

    def resolve_user_by_id(id)
      begin
        User.find(id)
      rescue ActiveRecord::RecordNotFound => e
        raise GraphQL::ExecutionError.new "User not found"
      end
    end
    
    def authorize_user_request
      token = context[:headers]["token"]
      uid = context[:headers]["uid"]
      user = resolve_user_by_id(uid)
      validate_correct_user_token(user, token)
    end

    def authorize_user_or_admin_request
      token = context[:headers]["token"]
      uid = context[:headers]["uid"]
      user = resolve_user_by_id(uid)
      validate_correct_user_or_admin_token(user, token)
    end
  end
end
