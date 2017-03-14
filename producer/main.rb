#!/usr/bin/env ruby
require 'bunny'

conn = Bunny.new
conn.start

ch = conn.create_channel
x  = ch.fanout('bunny.examples.hello_world')

%w(ceci est un message en plusieurs parties).each do |i|
  x.publish("Message #{i}")
end

conn.close
