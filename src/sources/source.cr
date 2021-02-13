class Source < Event
  def execute(msg : String)
    puts "Source: #{msg}"
  end
end
