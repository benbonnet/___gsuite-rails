module Firestore
  class Update < Firestore::Base
    def process
      index.update_documents([payload])

      payload
    end
  end
end
