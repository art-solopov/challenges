require 'arangodb/cursor'
require 'arangodb/query'
require 'arangodb/collection'
require 'arangodb/model'
require 'configuration'

module ArangoDB
  DBNAME = 'blog'

  class << self
    def connection
      @connection ||= begin
        host = Configuration.db_host
        port = Configuration.db_port
        Faraday.new(url: "http://#{host}:#{port}/_db/#{DBNAME}/_api/") do |faraday|
          faraday.request  :json
          faraday.response :json
          faraday.adapter  Faraday.default_adapter
        end
      end
    end
  end
end
