#!/usr/bin/env ruby
require 'bunny'

conn = Bunny.new
conn.start

ch = conn.create_channel
x  = ch.topic('bunny.examples.hello_world', auto_delete: true)

%w(ceci est un message en plusieurs parties).each do |i|
  x.publish("Message #{i}", routing_key: 'demo.test')
end

conn.close
