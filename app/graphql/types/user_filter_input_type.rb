# frozen_string_literal: true

module Types
  class UserFilterInputType < Types::BaseInputObject
    argument :OR, [self], required: false   
    argument :id, Integer, required: false
    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :email, String, required: false
    argument :password, String, required: false
    argument :mobile_number, String, required: false
    argument :birthdate, GraphQL::Types::ISO8601Date, required: false
    argument :gender, Integer, required: false
    argument :gender_interests, String, required: false
    argument :id_filter, Integer, required: false
    argument :matched_with_id, Integer, required: false
    argument :country, String, required: false
    argument :region, String, required: false
    argument :city, String, required: false
    argument :school, String, required: false
    argument :role, Integer, required: false
  end
end
