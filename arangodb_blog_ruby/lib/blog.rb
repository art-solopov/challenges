require 'models/post'

before do
  @collection = ArangoDB::Collection.new('posts')
end

helpers do
  def page
    params[:page].presence || 1
  end

  def posts
    @posts ||= Post.by_tags(page: page, tags: @tag)
  end

  def paginator
    @paginator ||= Post.paginator(tags: @tag)
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
