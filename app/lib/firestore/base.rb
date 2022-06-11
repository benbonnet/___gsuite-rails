require "google/cloud/firestore"

module Firestore
  class Base
    attr_reader(:collection_path, :id, :payload)

    def initialize(collection_path, id: nil, payload: {})
      @collection_path = collection_path
      @id = id || ::SecureRandom.uuid
      @payload = payload.merge(id: @id)
    end

    private

    def doc
      @doc ||= client.doc("#{collection_path}/#{id}")
    end

    def client
      @client ||= ::Google::Cloud::Firestore.new(project_id: "koinsdotapp")
    end
  end
end
