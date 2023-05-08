module Types
  class MutationType < Types::BaseObject
    field :like_check, mutation: Mutations::LikeCheck
    field :message_create, mutation: Mutations::MessageCreate
    field :like_back, mutation: Mutations::LikeBack
    field :dislike, mutation: Mutations::Dislike
    field :like, mutation: Mutations::Like
    field :user_sign_in, mutation: Mutations::UserSignIn
    field :user_delete, mutation: Mutations::UserDelete
    field :user_update, mutation: Mutations::UserUpdate
    field :user_create, mutation: Mutations::UserCreate
  end
end
