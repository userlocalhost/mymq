require 'bunny'

module MyMQ
  def self.channel_open(&block) 
    c = Bunny.new(:host => 'mqhost',
                  :user => 'user',
                  :password => 'password')
    c.start
    ch = c.create_channel
  
    block.call ch
  
    ch.close
    c.close
  end

  def self.send(data, name, rkey)
    channel_open do |ch|
      x = ch.direct(name)
      x.publish(data, :routing_key => rkey)
    end
  end

  def self.receive(name, rkey, &block)
    channel_open do |ch|
      x = ch.direct(name)
      
      q = ch.queue('', :exclusive => true)
      q.bind(x, :routing_key => rkey)
      
      begin
        q.subscribe(:block => true) do |info, prop, body|
          block.call(body)
        end
      rescue Exception => _
      end
    end
  end
end
