require 'arangodb'

class Post < ArangoDB::Model
  attribute :title, String
  attribute :body, String
  attribute :tags, Array[String]
end
