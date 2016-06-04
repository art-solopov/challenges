require 'models/post'

before do
  @collection = ArangoDB::Collection.new('posts')
end

helpers do
  def page
    params[:page].presence || 1
  end

  alias_method :current_page, :page

  def posts
    @posts ||= Post.by_tags(page: page, tags: @tag)
  end

  def paginator
    @paginator ||= Post.paginator(tags: @tag)
  end

  def page_href(page)
    if @tag
      url("/tags/#{@tag}?page=#{page}")
    else
      url("/?page=#{page}")
    end
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
