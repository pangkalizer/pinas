require "pinas/version"
require "pinas/loader"

module Pinas
  autoload :Location, "pinas/location"
end

require 'pinas/railtie' if defined?(Rails)
