module Mutations
  class UserSignIn < BaseMutation
    field :user, Types::UserType
    field :token, String

    argument :email, String, required: true
    argument :password, String, required: true

    def resolve(email: nil, password: nil)
      check_user_credentials(email, password)

      token = JsonWebToken.encode(user_id: @user.id)

      {user: @user, token: token}
    end
  end
end
