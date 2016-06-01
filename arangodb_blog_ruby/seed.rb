#!/usr/bin/env ruby

require 'bundler'
Bundler.require(:default, :development)
$LOAD_PATH << 'lib'

require 'arangodb'
require 'models/post'

posts = 1.upto(10).map do |i|
  Post.new(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraphs(3).join("\n\n"),
    tags: Faker::Lorem.words(5)
  )
end

puts JSON.pretty_generate(posts.map(&:to_json_data))
