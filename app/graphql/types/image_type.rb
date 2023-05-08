# frozen_string_literal: true

module Types
  class ImageType < Types::BaseObject
    field :url, String, null: false
    field :signed_id, Integer, null: false
  end
end
