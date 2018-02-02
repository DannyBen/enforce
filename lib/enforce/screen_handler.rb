require 'colsole'

module Enforce
  module ScreenHandler
    include Colsole
    include DSL

    def on_result(message:, pass:)
      status = pass ? "!txtgrn!PASS!txtrst!" : "!txtred!FAIL!txtrst!"
      say "#{status} #{message}"
    end
  end
end