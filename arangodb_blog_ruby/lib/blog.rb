require 'models/post'

PER_PAGE = 5

before do
  @collection = ArangoDB::Collection.new('posts')
end

helpers do
  def page
    params[:page].presence || 1
  end

  def posts
    @posts ||= @collection.paginate(page, PER_PAGE, tags: @tag)
             .execute.as(Post)
  end
end

get '/' do
  erb :index
end

get '/posts/:key' do
  @post = Post.get("posts/#{params[:key]}")
  erb :show
end

get '/tags/:tag' do
  @tag = params[:tag]
  erb :index
end
