module Firestore
  # Firestore::Index.new('users').process
  class Index
    attr_reader(:collection_path, :limit, :offset, :where)

    def initialize(collection_path, limit: 20, offset: nil, where: [])
      @collection_path = collection_path
      @limit = limit
      @offset = offset
      @where = where
    end

    def process
      collection.get.map(&:data)
    end

    private

    def collection
      @collection ||= client.col(collection_path)
    end

    def client
      @client ||= ::Google::Cloud::Firestore.new(project_id: "koinsdotapp")
    end
  end
end
