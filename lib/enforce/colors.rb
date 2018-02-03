module Enforce
  module Colors
    def colors
      {
        reset:  "\e[0m",  black:  "\e[30m", red:    "\e[31m",
        green:  "\e[32m", yellow: "\e[33m", blue:   "\e[34m",
        magenta:"\e[35m", cyan:   "\e[36m", white:  "\e[37m",
      }
    end

    def say(message)
      message.gsub!(/`([^`]+)`/, "%{blue}\\1%{reset}")
      puts "#{message}%{reset}" % colors
    end
  end
end
