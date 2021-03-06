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
      qry = tag_query(tags, collection) +
        " LIMIT @offset, @count SORT p.#{order} ASC RETURN p"

      ArangoDB::AQLQuery.new(
        qry,
        batch_size: per_page,
        bind_vars: {
          offset: (page - 1) * per_page,
          count: per_page,
          tags: tags,
          "@collection": collection
        }.compact
      ).execute.as(self)
    end

    def paginator(per_page: PER_PAGE, tags: nil, collection: :posts)
      subqry = <<-AQL
      COLLECT WITH COUNT INTO length
      RETURN {
        count: length,
        pages: CEIL(length / @per_page),
        enabled: length > @per_page
      }
      AQL
      # subqry = ' COLLECT WITH COUNT INTO length RETURN ' \
      #   '{count: length, pages: CEIL(length / @per_page)}'
      ArangoDB::AQLQuery.new(
        tag_query(tags, collection) + subqry,
        bind_vars: {
          per_page: per_page,
          tags: tags,
          "@collection": collection
        }.compact
      ).execute.result.first&.with_indifferent_access
    end

    private

    def tag_query(tags = nil, collection = :posts)
      qry = "FOR p IN @@collection"
      case tags
      when Array then qry += ' FILTER LENGTH(INTERSECTION(p.tags, @tags))'
      when -> (x) { x.present? } then qry += ' FILTER @tags IN p.tags'
      end
      qry
    end
  end

end
