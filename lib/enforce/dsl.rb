module Enforce
  class DSL
    attr_reader :last_file

    def file(name)
      pass = File.exist?(name)
      @last_file = name

      add_result message: "file `#{name}`", pass: pass

      return unless pass
      yield if block_given?
    end

    def no_file(name)
      pass = !File.exist?(name)
      add_result message: "no file `#{name}`", pass: pass
    end

    def folder(name)
      pass = Dir.exist?(name)
      add_result message: "folder `#{name}`", pass: pass

      return unless pass && block_given?

      Dir.chdir name do
        yield
      end
    end

    def with(content)
      content_as_string = content.is_a?(String) ? content : content.inspect
      add_result message: "with `#{content_as_string}`", 
        pass: File.read(last_file).match?(content)
    end

    def without(content)
      content_as_string = content.is_a?(String) ? content : content.inspect
      add_result message: "without `#{content_as_string}`", 
        pass: !File.read(last_file).match?(content)
    end

    def with_line(content)
      add_result message: "with line `#{content}`", 
        pass: File.readlines(last_file).map(&:strip).include?(content)
    end

    def without_line(content)
      add_result message: "without line `#{content}`", 
        pass: !File.readlines(last_file).map(&:strip).include?(content)
    end

    def results
      @results ||= []
    end

    def passed_results
      results.select { |result| result[:pass] }
    end

    def failed_results
      results.reject { |result| result[:pass] }
    end

    protected

    def add_result(result)
      results.push result unless results.include? result
      handle result
    end

    def handle(result)
      # Do nothing, should be overridden
    end
  end
end