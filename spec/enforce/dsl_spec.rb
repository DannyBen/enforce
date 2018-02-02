require 'spec_helper'

describe DSL do
  describe '#file' do
    context "when file exists" do
      it "creates a passing result" do
        subject.file 'Gemfile'
        expect(subject.results.last).to eq({ message: "File 'Gemfile' should exist", pass: true })
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
        expect(subject.results.last).to eq({ message: "File 'NoSuchFile' should exist", pass: false })
      end
    end
  end

  describe '#no_file' do
    context "when file exists" do
      it "creates a failing result" do
        subject.no_file 'GemFile'
        expect(subject.results.last).to eq({ message: "File 'GemFile' should not exist", pass: false })
      end
    end

    context "when file does not exist" do
      it "creates a passing result" do
        subject.no_file 'NoSuchFile'
        expect(subject.results.last).to eq({ message: "File 'NoSuchFile' should not exist", pass: true })
      end

    end
  end

end
