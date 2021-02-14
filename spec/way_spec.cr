require "./spec_helper"

describe Way do
  it "read toml" do
    toml_string = %(
      title = "TOML Example"

      [owner]
      name = "Lance Uppercut"
      dob = 1979-05-27T07:32:00Z
    )

    toml = TOML.parse(toml_string)
    toml["title"].should eq("TOML Example")
    owner = toml["owner"].as(Hash)
    owner["name"].should eq("Lance Uppercut")
    owner["dob"].should eq(Time::Format::RFC_3339.parse("1979-05-27T07:32:00Z"))
  end

  it "run events in a chain" do
    # Program
    # Build the chain of responsibility
    event = Source.new(LogLevel::All)
    event1 = event.next = Transform.new(LogLevel::FunctionalMessage, LogLevel::FunctionalError)
    event2 = event1.next = Blackhole.new(LogLevel::Warning, LogLevel::Error)

    # Calls
    event.call("Entering function ProcessOrder().", LogLevel::Debug)
    event.call("Order record retrieved.", LogLevel::Info)
    event.call("Customer Address details missing in Branch DataBase.", LogLevel::Warning)
    event.call("Customer Address details missing in Organization DataBase.", LogLevel::Error)
    event.call("Unable to Process Order ORD1 Dated D1 For Customer C1.", LogLevel::FunctionalError)
    event.call("Order Dispatched.", LogLevel::FunctionalMessage)
  end

  it "read and build" do
    toml_string = %(
      # API (disabled by default)
      [api]
      enabled = false

      [sources.foo]
      type = "source"

      # Print it all out for inspection
      [sinks.print]
      type = "console"
      inputs = ["foo"]

      )
    toml = TOML.parse(toml_string).select!(
      "api",
      "sources",
      "sinks",
      "transforms"
    )
    api = toml["api"].as(Hash)
    api["enabled"].should eq(false)

    sources = toml["sources"].as(Hash)
    sinks = toml["sinks"].as(Hash)

    sources.each do |k, v|
      puts v
    end

    if sinks
      s = sinks["print"].as(Hash)
      inputs = s["inputs"].as(Array)
      source = sources[inputs.pop].as(Hash)
      _type = source["type"].as(String).camelcase
      puts _type
    else
    end
  end
end
