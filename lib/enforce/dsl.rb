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

    def no_folder(name)
      pass = !Dir.exist?(name)
      add_result message: "no folder `#{name}`", pass: pass
    end

    def text(content)
      pass = File.read(last_file).include?(content)
      add_result message: "text `#{content}`", pass: pass
    end

    def no_text(content)
      pass = !File.read(last_file).include?(content)
      add_result message: "no_text `#{content}`", pass: pass
    end

    def regex(content)
      pass = File.read(last_file).match?(content)
      add_result message: "regex `#{content.inspect}`", pass: pass
    end

    def no_regex(content)
      pass = !File.read(last_file).match?(content)
      add_result message: "no_regex `#{content.inspect}`", pass: pass
    end

    def line(content)
      pass = File.readlines(last_file).map(&:strip).include?(content)
      add_result message: "line `#{content}`", pass: pass
    end

    def no_line(content)
      pass = !File.readlines(last_file).map(&:strip).include?(content)
      add_result message: "no line `#{content}`", pass: pass
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