require 'models/post'

PER_PAGE = 5

before do
  @collection = ArangoDB::Collection.new('posts')
end

get '/' do
  @posts = @collection.paginate(1, PER_PAGE).execute.as(Post)
  erb :index
end

get '/posts/:key' do
  @post = Post.get("posts/#{params[:key]}")
  erb :show
end
