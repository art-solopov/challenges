require 'models/post'

PER_PAGE = 5

get '/' do
  @collection = ArangoDB::Collection.new('posts')
  @posts = @collection.paginate(1, PER_PAGE).execute.as(Post)
  erb :index
end
