module Mutations
  class ImageDelete < BaseMutation
    description "Deletes a image by ID"

    field :status, String, null: false

    argument :id, ID, required: true

    def resolve(id:)
      image = ActiveStorage::Attachment.find_by(blob_id: id)
      user = image.record
      user.image.count

      raise GraphQL::ExecutionError.new "Error deleting image", extensions: image.errors.to_hash unless user.image.count > 1 && image.purge

      { status: "Image deleted" }
    end
  end
end
