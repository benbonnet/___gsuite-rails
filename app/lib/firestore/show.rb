module Store
	module Firestore
	  class Show < ::Store::Firestore::Base
	    def process
	      index.document(id)
	    end
	  end
	end
end