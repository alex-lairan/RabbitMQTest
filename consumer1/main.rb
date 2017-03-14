require 'bunny'
require 'pp'

conn = Bunny.new
conn.start

ch = conn.create_channel
x  = ch.topic('bunny.examples.hello_world', auto_delete: true)
q  = ch.queue('', exclusive: true)

q.bind(x, routing_key: 'demo.*')

begin
  q.subscribe block: true do |_delivery_info, _metadata, payload|
    puts "Received #{payload}"
  end
rescue Interrupt
  ch.close
  conn.close
end
