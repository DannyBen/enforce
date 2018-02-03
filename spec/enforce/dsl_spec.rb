require 'spec_helper'

describe DSL do
  describe '#file' do
    context "when file exists" do
      it "creates a passing result" do
        subject.file 'Gemfile'
        expect(subject.results.last[:pass]).to be true
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
        expect(subject.results.last[:pass]).to be false
      end
    end
  end

  describe '#no_file' do
    context "when file exists" do
      it "creates a failing result" do
        subject.no_file 'Gemfile'
        expect(subject.results.last[:pass]).to be false
      end
    end

    context "when file does not exist" do
      it "creates a passing result" do
        subject.no_file 'NoSuchFile'
        expect(subject.results.last[:pass]).to be true
      end
    end
  end

  describe '#folder' do
    context "when folder exists" do
      it "creates a passing result" do
        subject.folder 'spec'
        expect(subject.results.last[:pass]).to be true
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
        expect(subject.results.last[:pass]).to be false
      end
    end    
  end

  describe '#no_folder', :focus do
    context "when folder exists" do
      it "creates a failing result" do
        subject.no_folder 'spec'
        expect(subject.results.last[:pass]).to be false
      end
    end

    context "when folder does not exist" do
      it "creates a passing result" do
        subject.no_folder 'NoSuchFolder'
        expect(subject.results.last[:pass]).to be true
      end
    end    
  end

  describe '#text' do
    before do
      subject.file 'Gemfile'
    end

    context "when the file includes the string" do
      it "creates a passing result" do
        subject.text 'gemspec'
        expect(subject.results.last[:pass]).to be true
      end
    end

    context "when the file does not include the string" do
      it "creates a failing result" do
        subject.text 'NoSuchText'
        expect(subject.results.last[:pass]).to be false
      end
    end
  end

  describe '#no_text' do
    before do
      subject.file 'Gemfile'
    end

    context "when the file includes the content" do
      it "creates a failing result" do
        subject.no_text 'gemspec'
        expect(subject.results.last[:pass]).to be false
      end
    end

    context "when the file does not include the content" do
      it "creates a passing result" do
        subject.no_text 'NoSuchText'
        expect(subject.results.last[:pass]).to be true
      end
    end
  end

  describe "#regex" do
    before do
      subject.file 'Gemfile'
    end

    context "when the file includes the pattern", :focus do
      it "creates a passing result" do
        subject.regex(/^gem.pec$/)
        expect(subject.results.last[:pass]).to be true
      end
    end

    context "when the file does not include the pattern" do
      it "creates a failing result" do
        subject.regex(/..gemspec../)
        expect(subject.results.last[:pass]).to be false
      end
    end
  end

  describe '#no_regex' do
    before do
      subject.file 'Gemfile'
    end
    
    context "when the file includes the pattern" do
      it "creates a failing result" do
        subject.no_regex(/^gem.pec$/)
        expect(subject.results.last[:pass]).to be false
      end
    end

    context "when the file does not include the pattern" do
      it "creates a passing result" do
        subject.no_regex(/..gemspec../)
        expect(subject.results.last[:pass]).to be true
      end
    end
  end

  describe '#line' do
    before do
      subject.file 'Gemfile'
    end

    context "when the file includes the line" do
      it "creates a passing result" do
        subject.line 'source "https://rubygems.org"'
        expect(subject.results.last[:pass]).to be true
      end
    end

    context "when the file does not include the line" do
      it "creates a failing result" do
        subject.line 'https://rubygems.org'
        expect(subject.results.last[:pass]).to be false
      end
    end
  end

  describe '#no_line' do
    before do
      subject.file 'Gemfile'
    end

    context "when the file includes the line" do
      it "creates a failing result" do
        subject.no_line 'source "https://rubygems.org"'
        expect(subject.results.last[:pass]).to be false
      end
    end

    context "when the file does not include the line" do
      it "creates a passing result" do
        subject.no_line 'https://rubygems.org'
        expect(subject.results.last[:pass]).to be true
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
