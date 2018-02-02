module Enforce
  module DSL
    def file(name, with: nil, without: nil)
      pass = File.exist?(name)
      add_result message: "File '#{name}' should exist", pass: pass
      
      if pass and with
        add_result message: "File '#{name}' should contain '#{with}'", 
          pass: File.read(name).include?(with)
      end

      if pass and without
        add_result message: "File '#{name}' should not contain '#{with}'", 
          pass: !File.read(name).include?(without)
      end
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

    def results
      @results ||= []
    end

    def add_result(result)
      results.push result unless results.include? result
      on_result result if respond_to? :on_result
    end
  end
end