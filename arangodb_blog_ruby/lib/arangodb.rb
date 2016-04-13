require 'bundler/setup'
Bundler.require(:default)
require_relative 'arangodb/cursor'
require_relative 'arangodb/collection'

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
