require 'virtus'
require 'json'

module ArangoDB
  class Model
    include Virtus.model

    attribute :_id, String
    attribute :_rev, Integer
    attribute :_key, Integer

    def to_json_data
      to_hash.except(* %i(_id _rev _key))
    end

    def read_metadata(body)
      self._id = body['id']
      self._rev = body['rev']
      self._key = body['key']
    end

    class << self
      def all(collection, limit: nil)
        SimpleQuery.new(:all, collection: collection, limit: limit)
          .execute.as(self)
      end

      def get(id)
        response = ArangoDB.connection.get("document/#{id}")
        new(response.body)
      end
    end
  end
end
