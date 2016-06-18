require 'bundler'
Bundler.require(:default, :development)
LIB_DIR = File.expand_path('lib', File.dirname(__FILE__))
$LOAD_PATH << LIB_DIR

require 'blog'

run Sinatra::Application
