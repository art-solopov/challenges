require 'arangodb/cursor'
require 'arangodb/query'
require 'arangodb/collection'

module ArangoDB
  class << self
    def connection
      @connection ||= Faraday.new(url: 'http://localhost:8529/_db/blog/_api/') do |faraday|
        faraday.request  :json
        faraday.response :json
        faraday.adapter  Faraday.default_adapter
      end
    end
  end
end
