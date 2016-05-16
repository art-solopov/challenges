require 'arangodb'

class Post < ArangoDB::Model
  attribute :title, String
  attribute :body, String
  attribute :tags, Array[String]
  attribute :created_at, DateTime, default: -> { Time.now }
end
