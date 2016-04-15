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
  end
end
