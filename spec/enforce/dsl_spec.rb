require 'spec_helper'

describe DSL do
  describe '#file' do
    context "when file exists" do
      it "creates a passing result" do
        subject.file 'Gemfile'
        expect(subject.results.last.to_s).to match_fixture :dsl_file_1
      end

      context "when a block is given" do
        it "yields the block" do
          @yielded = false
          subject.file('Gemfile') { @yielded = true }
          expect(@yielded).to be true
        end
      end
    end

    context "when file does not exist" do
      it "creates a failing result" do
        subject.file 'NoSuchFile'
        expect(subject.results.last.to_s).to match_fixture :dsl_file_2
      end
    end
  end

  describe '#no_file' do
    context "when file exists" do
      it "creates a failing result" do
        subject.no_file 'Gemfile'
        expect(subject.results.last.to_s).to match_fixture :dsl_no_file_1
      end
    end

    context "when file does not exist" do
      it "creates a passing result" do
        subject.no_file 'NoSuchFile'
        expect(subject.results.last.to_s).to match_fixture :dsl_no_file_2
      end
    end
  end

  describe '#folder' do
    context "when folder exists" do
      it "creates a passing result" do
        subject.folder 'spec'
        expect(subject.results.last.to_s).to match_fixture :dsl_folder
      end

      context "when a block is given" do
        it "changes directory and yields the block" do
          @yielded, @pwd = false, nil

          subject.folder('spec') { @yielded = true; @pwd = Dir.pwd }
          expect(@yielded).to be true
          expect(@pwd).to match /spec$/
        end
      end
    end

    context "when folder does not exist" do
      it "creates a failing result" do
        subject.folder 'NoSuchFolder'
        expect(subject.results.last.to_s).to match_fixture :dsl_folder_2
      end
    end    
  end

  describe '#with' do
    before do
      subject.file 'Gemfile'
    end

    context "with a string argument" do
      context "when the file includes the string" do
        it "creates a passing result" do
          subject.with 'gemspec'
          expect(subject.results.last.to_s).to match_fixture :dsl_with_1
        end
      end

      context "when the file does not include the string" do
        it "creates a failing result" do
          subject.with 'NoSuchText'
          expect(subject.results.last.to_s).to match_fixture :dsl_with_2
        end
      end
    end

    context "with a regex argument" do
      context "when the file includes the pattern" do
        it "creates a passing result" do
          subject.with(/^gem.pec$/)
          expect(subject.results.last.to_s).to match_fixture :dsl_with_3
        end
      end

      context "when the file does not include the pattern" do
        it "creates a failing result" do
          subject.with(/..gemspec../)
          expect(subject.results.last.to_s).to match_fixture :dsl_with_4
        end
      end
    end
  end

  describe '#without' do
    before do
      subject.file 'Gemfile'
    end

    context "with a string argument" do

      context "when the file includes the content" do
        it "creates a failing result" do
          subject.without 'gemspec'
          expect(subject.results.last.to_s).to match_fixture :dsl_without_1
        end
      end

      context "when the file does not include the content" do
        it "creates a passing result" do
          subject.without 'NoSuchText'
          expect(subject.results.last.to_s).to match_fixture :dsl_without_2
        end
      end
    end

    context "with a regex argument" do
      context "when the file includes the pattern" do
        it "creates a failing result" do
          subject.without(/^gem.pec$/)
          expect(subject.results.last.to_s).to match_fixture :dsl_without_3
        end
      end

      context "when the file does not include the pattern" do
        it "creates a passing result" do
          subject.without(/..gemspec../)
          expect(subject.results.last.to_s).to match_fixture :dsl_without_4
        end
      end
    end
  end

  describe '#with_line' do
    before do
      subject.file 'Gemfile'
    end

    context "when the file includes the line" do
      it "creates a passing result" do
        subject.with_line 'source "https://rubygems.org"'
        expect(subject.results.last.to_s).to match_fixture :dsl_with_line_1
      end
    end

    context "when the file does not include the line" do
      it "creates a failing result" do
        subject.with_line 'https://rubygems.org'
        expect(subject.results.last.to_s).to match_fixture :dsl_with_line_2
      end
    end
  end

  describe '#without_line' do
    before do
      subject.file 'Gemfile'
    end

    context "when the file includes the line" do
      it "creates a failing result" do
        subject.without_line 'source "https://rubygems.org"'
        expect(subject.results.last.to_s).to match_fixture :dsl_without_line_1
      end
    end

    context "when the file does not include the line" do
      it "creates a passing result" do
        subject.without_line 'https://rubygems.org'
        expect(subject.results.last.to_s).to match_fixture :dsl_without_line_2
      end
    end
  end


  describe '#passed_results' do
    before do
      subject.file 'Gemfile'
      subject.file 'README.md'
      subject.file 'NoSuchFile'
      expect(subject.results.count).to eq 3
    end

    it "returns an array of passed results" do
      expect(subject.passed_results.count).to eq 2
    end
  end

  describe '#failed_results' do
    before do
      subject.file 'Gemfile'
      subject.file 'NoSuchFile'
      subject.file 'NoSuchFileEither'
      expect(subject.results.count).to eq 3
    end

    it "returns an array of passed results" do
      expect(subject.failed_results.count).to eq 2
    end
  end

end
