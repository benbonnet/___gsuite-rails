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
      chain_where.get.map do |rec|
        { id: rec.document_id }.merge(rec.data)
      end
    end

    private

    def chain_where
      where.inject(collection) { |acc, values| acc.where(*values) }
    end

    def collection
      @collection ||= FIRESTORE_CLIENT.col(collection_path)
    end
  end
end
