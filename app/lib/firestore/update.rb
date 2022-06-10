module Store
	module Firestore
	  class Update < ::Store::Firestore::Base
	    def process
	      index.update_documents([payload])

	      payload
	    end
	  end
	end
end