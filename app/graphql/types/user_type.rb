# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :full_name, String, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :mobile_number, String, null: false
    field :email, String, null: false
    field :birthdate, GraphQL::Types::ISO8601Date, null: false
    field :gender, GenderType, null: false
    field :country, String, null: false
    field :region, String, null: false
    field :city, String, null: false
    field :school, String
    field :bio, String, null: false
    field :role, RoleType, null: false
    field :matches, [Types::MatchType]
    field :image_url, [Types::ImageType]
    field :interests, [Types::InterestType]

    def image_url
      if object.image.attached?
        if Rails.env.production?
          object.image.reduce([]) { |array_of_url, image| array_of_url + [{url: image.url, signed_id: image.id}]}
        else
          object.image.reduce([]) { |array_of_url, image| array_of_url + [{url: Rails.application.routes.url_helpers.rails_blob_url(image), signed_id: image.id}]}
        end
      end
    end

    def full_name
      object.full_name
    end
  end
end
