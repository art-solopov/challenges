#!/usr/bin/env ruby

require 'bundler'
Bundler.require(:default, :development)
$LOAD_PATH << 'lib'

require 'arangodb'
binding.pry
