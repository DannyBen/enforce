require 'singleton'
require 'colsole'

module Enforce
  class Handler < DSL
    include Singleton
    include Colsole

    def execute(argv)
      eval File.read 'dev/sample.rb'
      color = failed? ? "!txtred!" : "!txtgrn!"
      say "#{color}#{results.count} rules, #{failed} failures"
    end

    def failed
      failed_results.count
    end

    def failed?
      failed_results.count > 0
    end

    def handle(message:, pass:)
      status = pass ? "!txtgrn!PASS!txtrst!" : "!txtred!FAIL!txtrst!"
      say "#{status} #{message}"
    end
  end
end