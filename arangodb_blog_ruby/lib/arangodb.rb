require 'arangodb/cursor'
require 'arangodb/query'
require 'arangodb/collection'
require 'arangodb/model'

module ArangoDB
  class << self
    def connection
      host = ENV['DBHOST'] || 'localhost'
      port = ENV['DBPORT'] || '8529'
      @connection ||= Faraday.new(url: "http://#{host}:#{port}/_db/blog/_api/") do |faraday|
        faraday.request  :json
        faraday.response :json
        faraday.adapter  Faraday.default_adapter
      end
    end
  end
end
