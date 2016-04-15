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

  class AQLQuery
  end
end
