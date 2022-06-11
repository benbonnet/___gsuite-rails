require 'google/cloud/firestore'

module Firestore
  # Firestore::Show.new('users', '05ef9a86-1aaf-4306-af92-c0a37ba2a0b1')
  class Show
    attr_reader(:collection_path, :id)

    def initialize(collection_path, id)
      @collection_path = collection_path
      @id = id
    end

    def process
      ref = client.doc("#{collection_path}/#{id}")
      { id: ref.document_id }.merge(ref.get.data)
    end

    private

    def client
      @client ||= ::Google::Cloud::Firestore.new(project_id: "koinsdotapp")
    end
  end
end
