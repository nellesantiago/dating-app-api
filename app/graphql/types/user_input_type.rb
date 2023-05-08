# frozen_string_literal: true

module Types
  class UserInputType < Types::BaseInputObject
    argument :id, ID, required: false
    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :email, String, required: false
    argument :password, String, required: false
    argument :mobile_number, String, required: false
    argument :birthdate, String, required: false
    argument :gender, GenderType, required: false
    argument :country, String, required: false
    argument :region, String, required: false
    argument :city, String, required: false
    argument :school, String, required: false
    argument :bio, String, required: false
    argument :created_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :updated_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :image, [Types::UploadType], required: false
  end
end
