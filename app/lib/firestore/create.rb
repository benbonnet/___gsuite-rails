module Store
  module Firestore
    class Create < ::Store::Firestore::Base
	    def process
				doc.set(payload)
	    end
	  end
  end
end