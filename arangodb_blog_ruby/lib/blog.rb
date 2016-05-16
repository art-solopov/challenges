require 'models/post'

PER_PAGE = 5

get '/' do
  @collection = ArangoDB::Collection.new('posts')
  @posts = @collection.first(PER_PAGE).execute.as(Post)
  erb :index
end
