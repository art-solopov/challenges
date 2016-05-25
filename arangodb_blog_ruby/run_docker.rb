#!/usr/bin/env ruby
require 'json'

Image = Struct.new(:image, :id)

class Image
  def self.get(all: false)
    command = 'docker ps --format "{{.Image}}||{{.ID}}"'
    command += ' -a' if all
    command += ' | grep arangodb'
    `#{command}`.strip.split("\n")
      .map { |d| Image.new(*d.split('||')) }
  end
end

def run_arangodb
  image = Image.get(all: true).first
  system("docker start #{image.id}")
  [image]
end

def main
  # Find ArangoDB machine
  arangodb_images = Image.get
  case arangodb_images.length
  when 0
    puts "Starting an ArangoDB interface"
    arangodb_images = run_arangodb
  when -> (x) { x > 1 }
    puts 'Ambigous ArangoDB host'
    exit(2)
  end

  image_id = arangodb_images.first.id
  inspect = JSON.parse(`docker inspect #{image_id}`)
  ip = inspect[0]['NetworkSettings']['Networks']['bridge']['IPAddress']

  command = "docker run -p 4567:4567" \
            " -e DBHOST=#{ip} -it art-solopov/arangoblog-ruby" \
            " bundle exec /app/app.rb -o 0.0.0.0"
  system(command)
end

main
