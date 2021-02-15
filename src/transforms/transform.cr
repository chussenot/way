module Way
  class Transform < Event
    def execute(msg : String)
      puts "Transform: #{msg}"
    end
  end
end
