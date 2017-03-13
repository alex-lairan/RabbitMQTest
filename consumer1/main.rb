require 'bunny'
require 'pp'

conn = Bunny.new
conn.start

ch = conn.create_channel
q  = ch.queue('bunny.examples.hello_world', auto_delete: true)

q.subscribe block: true do |_delivery_info, _metadata, payload|
  puts "Received #{payload}"
end

sleep 1.0
conn.close
