module Enforce
  class DSL
    attr_reader :last_file

    def file(name)
      pass = File.exist?(name)
      @last_file = name

      add_result message: "File '#{name}' should exist", pass: pass

      return unless pass
      
      yield if block_given?
    end

    def no_file(name)
      add_result message: "File '#{name}' should not exist", 
        pass: !File.exist?(name)
    end

    def folder(name)
      pass = Dir.exist?(name)
      add_result message: "Folder '#{name}' should exist", pass: pass

      return unless pass && block_given?

      Dir.chdir name do
        yield
      end
    end

    def with(string)
      add_result message: "File '#{last_file}' should contain '#{string}'", 
        pass: File.read(last_file).include?(string)
    end

    def without(string)
      add_result message: "File '#{last_file}' should not contain '#{string}'", 
        pass: !File.read(last_file).include?(string)
    end

    def results
      @results ||= []
    end

    protected

    def add_result(result)
      results.push result unless results.include? result
      handle result
    end

    def passed_results
      results.select { |result| result[:pass] }
    end

    def failed_results
      results.reject { |result| result[:pass] }
    end

    def handle(result)
      # Do nothing, should be overridden
    end
  end
end