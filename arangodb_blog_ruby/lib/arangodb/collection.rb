module ArangoDB
  class Collection
    def initialize(name)
      @name = name
      res = ArangoDB.connection.get("collection/#{name}")
      if res.success?
        @persisted = true
        @type = res.body['type']
      end
    end

    attr_accessor :name, :persisted, :type

    def persisted?
      @persisted
    end
  end
end
