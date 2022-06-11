require 'google/cloud/firestore'

module Firestore
  # Firestore::Update.new('users', '05ef9a86-1aaf-4306-af92-c0a37ba2a0b1', { name: "LLL", XX: :A}).process
  class Update
    attr_reader(:collection_path, :id, :payload)

    def initialize(collection_path, id, payload)
      @collection_path = collection_path
      @id = id
      @payload = payload
    end

    def process
      ref = client.doc("#{collection_path}/#{id}")
      ref.set(payload, merge: true)
      { id: ref.document_id }.merge(ref.get.data)
    end

    private

    def client
      @client ||= ::Google::Cloud::Firestore.new(project_id: "koinsdotapp")
    end
  end
end
