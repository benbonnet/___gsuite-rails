module Store
  module Firestore
    class Base < ApplicationService
      attr_reader :collection_path, :id, :payload

      def initialize(collection_path, id: nil, payload: {})
        @collection_path = collection_path
        @id = id || ::SecureRandom.uuid
        @payload = payload.merge(id: @id)
      end

      private

      def doc
        @doc ||= ::FIRESTORE_CLIENT.doc "#{collection_path}/#{id}"
      end
    end
  end
end
