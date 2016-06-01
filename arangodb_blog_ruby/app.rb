#!/usr/bin/env ruby

require 'bundler'
Bundler.require(:default, :development)
require 'sinatra'
$LOAD_PATH << File.expand_path('lib', File.dirname(__FILE__))

require 'blog'
