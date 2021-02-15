module Way
  class Sink < Event
    def execute(msg : String)
    end
  end

  class Blackhole < Sink
    def execute(msg : String)
      super
      return
    end
  end

  class Console < Sink
    def execute(msg : String)
      super
      puts msg
    end
  end
end
