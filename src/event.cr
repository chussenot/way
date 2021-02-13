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
      execute(msg)
    end
    @next.try(&.call(msg, severity))
  end

  abstract def execute(msg : String)
end
