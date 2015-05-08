require "pinas/version"

module Pinas
  autoload :Location, "pinas/location"
end

require 'pinas/railtie' if defined?(Rails)
