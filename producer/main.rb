#!/usr/bin/env ruby
require 'bunny'

conn = Bunny.new
conn.start

ch = conn.create_channel
q  = ch.queue('bunny.examples.hello_world', auto_delete: true)
x  = ch.default_exchange

5.times do |i|
  x.publish("Message #{i} - #{q.name}", routing_key: q.name)
end

conn.close
