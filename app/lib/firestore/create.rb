require 'google/cloud/firestore'

module Firestore
	# Firestore::Create.new('users', id: 123, payload: { name: "ok" }).process
  class Create
  	attr_reader(:collection_path, :payload)

  	def initialize(collection_path, payload)
  		@collection_path = collection_path
  		@payload = payload
  	end

    def process
			doc.set(payload)
			element = doc.get
			element.data.merge(id: element.document_id)
    end

    private

    def doc
      @doc ||= client.doc("#{collection_path}/#{id}")
    end

    def id
    	@id ||= SecureRandom.uuid
    end

    def client
      @client ||= ::Google::Cloud::Firestore.new
    end
  end
end
