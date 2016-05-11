require 'virtus'
require 'json'

module ArangoDB
  class Model
    include Virtus.model

    attribute :_id, String
    attribute :_rev, Integer
    attribute :_key, Integer

    def save(collection)
      if @_id then update(collection) else create(collection) end
    end

    def to_json_data
      to_hash.except(* %i(_id _rev _key))
    end

    def create(collection)
      res = ArangoDB.connection.post(
        "document?collection=#{collection}", to_json_data.to_json)
      body = res.body
      return false if body['error']
      read_metadata(body)
      true
    end

    def update(collection)
      res = ArangoDB.connection.put(
        "document/#{collection}/#{_key}", to_json_data.to_json
      )
      body = res.body
      return false if body['error']
      read_metadata(body)
      true
    end

    def read_metadata(body)
      self._id = body['id']
      self._rev = body['rev']
      self._key = body['key']
    end

    private :create, :update, :read_metadata

    class << self
      def all(collection, limit: nil)
        SimpleQuery.new(:all, collection: collection, limit: limit)
          .execute.as(self)
      end
    end
  end
end
