# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :mobile_number, String, null: false
    field :email, String, null: false
    field :birthdate, GraphQL::Types::ISO8601Date, null: false
    field :gender, GenderType, null: false
    field :gender_interest, GenderInterestType, null: false
    field :country, String, null: false
    field :region, String, null: false
    field :city, String, null: false
    field :school, String
    field :bio, String, null: false
    field :role, RoleType, null: false
  end
end
