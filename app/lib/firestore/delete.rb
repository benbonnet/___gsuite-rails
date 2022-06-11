module Firestore
  class Delete < Firestore::Base
    def process
      client.index.delete_document(id)
    end
  end
end
