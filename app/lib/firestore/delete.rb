module Store
	module Firestore
	  class Delete < ::Store::Firestore::Base
	    def process
	      index.delete_document(id)
	    end
	  end
	end
end