# frozen_string_literal: true

module Types
  class UploadType < Types::BaseScalar
    def self.coerce_input(input_values, context)
      # Override this to prepare a client-provided GraphQL value for your Ruby code
      # input_value
      graphql_name "Upload"
      description "action_dispatch_uploaded_file"

      return nil if input_values.nil?

      values = input_values.values.each do |input_value|
        ActionDispatch::Http::UploadedFile.new(
          filename: input_value.original_filename,
          type: input_value.content_type,
          head: input_value.headers,
          tempfile: input_value.tempfile,
        )
      end
    end

    def self.coerce_result(ruby_value, context)
      # Override this to serialize a Ruby value for the GraphQL response
      ruby_value.to_s
    end
  end
end
