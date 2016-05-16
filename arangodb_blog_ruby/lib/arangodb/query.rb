module ArangoDB
  class BaseQuery
    attr_accessor :cursor

    def execute
    end
  end

  class SimpleQuery < BaseQuery
    attr_reader :type
    attr_accessor :body

    def initialize(type, **body)
      @type = type
      @body = body
    end

    def execute
      response = ArangoDB.connection.put "simple/#{@type}", @body
      Cursor.new(response: response)
    end
  end

  class AQLQuery < BaseQuery
    attr_accessor :query
    attr_accessor :batch_size
    attr_accessor :bind_vars

    def initialize(query, batch_size: 50, bind_vars: nil)
      @query = query
      @batch_size = batch_size
      @bind_vars = bind_vars
    end

    def execute
      Cursor.new(
        response: ArangoDB.connection.post('cursor',
                                           { query: @query,
                                             count: true,
                                             batchSize: @batch_size,
                                             bindVars: @bind_vars }
                                          )
      )
    end
  end
end
