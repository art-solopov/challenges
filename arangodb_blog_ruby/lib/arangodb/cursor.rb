module ArangoDB
  class Cursor
    def initialize(response)
      body = response.body
      @has_more = body['hasMore']
      @result = body['result']
      @id = body['id']
    end
  end
end
