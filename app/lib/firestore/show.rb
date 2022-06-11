module Firestore
  class Show < Firestore::Base
    def process
      client.index.document(id)
    end
  end
end
