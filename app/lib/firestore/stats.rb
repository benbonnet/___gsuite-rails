module Store
	module Firestore
	  class Stats < ::Store::Firestore::Base
	    attr_reader :index_name

	    def initialize(index_name)
	      @index_name = index_name
	    end

	    def process
	      client.index(index_name).stats
	    end
	  end
	end
end
