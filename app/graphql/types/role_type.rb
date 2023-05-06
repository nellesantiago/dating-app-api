# frozen_string_literal: true

module Types
  class RoleType < Types::BaseEnum
    description "Role type enum"
    value "user"
    value "admin"
  end
end
