require 'singleton'

module Enforce
  class Handler < DSL
    include Colors

    def execute(file)
      eval File.read file
      color = failed? ? "%{red}" : "%{green}"
      say "#{color}#{results.count} rules, #{failed} failures"
    end

    def failed
      failed_results.count
    end

    def failed?
      failed_results.count > 0
    end

    def handle(message:, pass:)
      status = pass ? "%{green}PASS%{reset}" : "%{red}FAIL%{reset}"
      say "#{status} #{message}"
    end
  end
end