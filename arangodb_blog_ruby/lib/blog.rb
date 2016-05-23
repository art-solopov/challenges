require 'models/post'

PER_PAGE = 5

before do
  @collection = ArangoDB::Collection.new('posts')
end

helpers do
  def page
    params[:page].presence || 1
  end
end

get '/' do
  @posts = @collection.paginate(page, PER_PAGE).execute.as(Post)
  erb :index
end

get '/posts/:key' do
  @post = Post.get("posts/#{params[:key]}")
  erb :show
end

get '/tags/:tag' do
  @tag = params[:tag]
  @posts = @collection.paginate(page, PER_PAGE, tags: @tag)
           .execute.as(Post)
  erb :index
end
