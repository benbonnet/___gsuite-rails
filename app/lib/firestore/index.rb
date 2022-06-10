module Store
  module Firestore
    class Index < ::Store::Firestore::Base
      attr_reader :collection_path, :limit, :offset

      def initialize(collection_path, limit: 20, offset: nil)
        @collection_path = collection_path
        @limit = limit
        @offset = offset
      end

      def process
        collection.get.map(&:data)
      end

      private

      def collection
        @collection ||= ::FIRESTORE_CLIENT.col collection_path
      end
    end
  end
end
