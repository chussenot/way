enum LogLevel
  None
  Info
  Debug
  Warning
  Error
  FunctionalMessage
  FunctionalError
  All
end

abstract class Event
  property log_levels
  property next : Event | Nil

  def initialize(*levels)
    @log_levels = [] of LogLevel

    levels.each do |level|
      @log_levels << level
    end
  end

  def call(msg : String, severity : LogLevel)
    if @log_levels.includes?(LogLevel::All) || @log_levels.includes?(severity)
      write_message(msg)
    end
    @next.try(&.call(msg, severity))
  end

  abstract def write_message(msg : String)
end

class Source < Event
  def write_message(msg : String)
    puts "Writing to console: #{msg}"
  end
end

class Transform < Event
  def write_message(msg : String)
    puts "Sending via email: #{msg}"
  end
end

class Sink < Event
  def write_message(msg : String)
    puts "Writing to Log File: #{msg}"
  end
end
