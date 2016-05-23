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

    def paginate(page, per_page, order: :created_at, tags: nil)
      qry = "FOR p IN @@collection"
      case tags
      when Array then qry += ' FILTER LENGTH(INTERSECTION(p.tags, @tags))'
      when -> (x) { x.present? } then qry += ' FILTER @tags IN p.tags'
      end
      qry += " LIMIT @offset, @count SORT p.#{order} ASC RETURN p"

      AQLQuery.new(
        qry,
        batch_size: per_page,
        bind_vars: {
          offset: (page - 1) * per_page,
          count: per_page,
          tags: tags,
          "@collection": name
        }.compact
      )
    end

    def save(document)
      data = document.to_json_data
      response = if document._id
                   update_document(document._key, data)
                 else
                   create_document(data)
                 end
      body = response.body
      return false if body['error']
      document._id = body['id']
      document._rev = body['rev']
      document._key = body['key']
      true
    end

    private

    def create_document(data)
      ArangoDB.connection.post("document?collection=#{name}", data.to_json)
    end

    def update_document(key, data)
      ArangoDB.connection.put("document/#{name}/#{key}", data.to_json)
    end
  end
end
