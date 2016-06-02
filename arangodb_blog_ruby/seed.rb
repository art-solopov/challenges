#!/usr/bin/env ruby

require 'bundler'
Bundler.require(:default, :development)
$LOAD_PATH << 'lib'

require 'arangodb'
require 'models/post'

tags = 1.upto(12).map { Faker::Lorem.word  }.uniq

posts = 1.upto(20).map do |i|
  Post.new(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraphs(3).join("\n\n"),
    tags: tags.sample(rand(3..7))
  )
end

File.open('seed.json', 'w') do |f|
  f.write JSON.pretty_generate(posts.map(&:to_json_data))
end
