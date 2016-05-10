require 'virtus'

module ArangoDB
  class Model
    include Virtus.model

    attribute :_id, String
    attribute :_rev, Integer
    attribute :_key, Integer

    class << self
      def all(collection, limit: nil)
        SimpleQuery.new(:all, collection: collection, limit: limit)
          .execute.as(self)
      end
    end
  end
end
