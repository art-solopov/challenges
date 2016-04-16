module ArangoDB
  class Cursor
    include Virtus.model

    attribute :id, Integer
    attribute :has_more, Boolean
    attribute :result, Array
    attribute :count, Integer
    attribute :error, String
    attribute :status, Integer

    def initialize(options)
      super
      if options[:response]
        from_response options[:response]
      end
    end

    def from_response(response)
      @status = response.status
      body = response.body
      @has_more = body['hasMore']
      @result = body['result']
      @id = body['id']
      @count = body['count']
      @error = body['errorMessage']
    end

    def next
      response = ArangoDB.connection.put "cursor/#{id}"
      from_response response
    end
  end
end
