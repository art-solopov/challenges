require 'arangodb'

class Post < ArangoDB::Model
  attribute :title, String
  attribute :body, String
  attribute :tags, Array[String]
  attribute :created_at, DateTime, default: proc { Time.now }

  PER_PAGE = 10

  class << self
    def by_tags(page: 1, per_page: PER_PAGE,
                order: :created_at, tags: nil, collection: :posts)

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
      ).execute.as(self)
    end
  end

end
