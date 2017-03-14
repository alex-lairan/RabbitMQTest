require 'bunny'
require 'pp'

conn = Bunny.new
conn.start

ch = conn.create_channel
x  = ch.fanout('bunny.examples.hello_world')
q  = ch.queue('', exclusive: true)

q.bind(x)

begin
  q.subscribe block: true do |_delivery_info, _metadata, payload|
    puts "Received #{payload}"
  end
rescue Interrupt
  ch.close
  conn.close
end
