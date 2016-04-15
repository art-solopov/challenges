module ArangoDB
  class Cursor
    include Virtus.model

    attribute :id, Integer
    attribute :has_mode, Boolean
    attribute :result, Array

    def initialize(options)
      super
      if options[:response]
        from_response options[:response]
      end
    end

    def from_response(response)
      body = response.body
      @has_more = body['hasMore']
      @result = body['result']
      @id = body['id']
    end

    def next
      response = ArangoDB.connection.put "cursor/#{id}"
      from_response response
    end
  end
end
