#!/usr/bin/env ruby

require 'bundler'
Bundler.require(:default, :development)
require 'sinatra'
$LOAD_PATH << 'lib'

require 'blog'
