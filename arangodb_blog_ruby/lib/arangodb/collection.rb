module ArangoDB
  class Collection
    def initialize(name)
      @name = name
      res = ArangoDB.connection.get("collection/#{name}")
      puts res.status
      if res.success?
        @persisted = true
        @type = res.body['type']
      end
    end

    attr_accessor :name, :persisted, :type

    def persisted?
      @persisted
    end

    def create
      return if @persisted
      ArangoDB.connection.post('collection', { name: @name }).success?
    end

    def simple_query(skip: nil, limit: nil)
      params = {
        collection: @name,
        skip: skip,
        limit: limit
      }.reject { |_, v| v.nil? }
      res = ArangoDB.connection.put('simple/all', params)
      Cursor.new(res)
    end
  end
end
