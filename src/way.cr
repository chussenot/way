module Way
  VERSION = "0.1.0"
end

require "toml"
require "./event"
require "./sources/*"
require "./transforms/*"
require "./sinks/*"
