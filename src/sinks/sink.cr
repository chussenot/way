class Sink < Event
  def execute(msg : String)
    puts "Sink: #{msg}"
  end
end

class Blackhole < Sink
  def execute(msg : String)
    super
    puts "Blackhole"
    return
  end
end