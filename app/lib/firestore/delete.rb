require 'google/cloud/firestore'

module Firestore
	# Firestore::Delete.new('users', '123222').process
  class Delete
  	attr_reader(:collection_path, :id)

  	def initialize(collection_path, id)
  		@collection_path = collection_path
  		@id = id
  	end

    def process
    	ref = client.doc("#{collection_path}/#{id}")
    	ref.delete
    end

    private

    def client
      @client ||= ::Google::Cloud::Firestore.new(project_id: "koinsdotapp")
    end
  end
end
