require 'singleton'

module Enforce
  class CommandLine
    include Singleton

    def execute(argv=[])
      return show_usage if argv.empty?

      file = find_file argv[0]
      return show_file_not_found unless file

      handler.execute file
      handler.failed? ? 1 : 0
    end

    private

    def find_file(basename)
      candidates = [
        "#{basename}.rb",
        "#{home_dir}/#{basename}.rb"
      ]

      candidates.each do |candidate|
        return candidate if File.exist? candidate
      end

      false
    end

    def handler
      @handler ||= Enforce::Handler.new
    end

    def show_usage
      puts "Enforce #{Enforce::VERSION}"
      puts "  Usage: enforce RULES_FILE"
      0
    end

    def show_file_not_found
      puts "Error: Could not find rules file"
      1
    end

    def home_dir
      ENV['ENFORCE_HOME'] ||= "#{Dir.home}/enforce"
    end

  end
end


