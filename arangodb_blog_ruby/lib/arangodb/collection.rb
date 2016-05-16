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

    def first(count, skip: nil)
      SimpleQuery.new(:first, { collection: @name, count: count, skip: skip }.compact)
    end

    def last(count, skip: nil)
      SimpleQuery.new(:last, { collection: @name, count: count, skip: skip }.compact)
    end

    def paginate(page, per_page, order: :created_at)
      AQLQuery.new(
        "FOR p IN #{@name} LIMIT @offset, @count SORT p.#{order} ASC RETURN p",
        bind_vars: { offset: (page - 1) * per_page, count: per_page }
      )
    end
  end
end
