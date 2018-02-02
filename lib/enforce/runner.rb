require 'singleton'

module Enforce
  class Runner
    include Singleton
    include DSL

    def execute(argv)
      load 'dev/sample.rb'
      p results
    end
  end
end