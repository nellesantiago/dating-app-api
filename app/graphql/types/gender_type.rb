# frozen_string_literal: true

module Types
  class GenderType < Types::BaseEnum
    description "Gender type enum"
    value "man"
    value "woman"
    value "nonbinary"
  end
end
