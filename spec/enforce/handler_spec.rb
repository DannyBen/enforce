require 'spec_helper'

describe Handler do
  describe '#execute' do
    let(:script) { 'spec/scripts/basic.rb' }

    it "runs the script" do
      expect{ subject.execute script }.to output_approval :handler_execute
    end
  end

  describe '#handle' do
    it "prints a message" do
      expect{ subject.handle message: 'hi', pass: true }.to output_approval :handler_handle
    end
  end

  context "when the script has a failed rule" do
    let(:script) { 'spec/scripts/failure.rb' }

    describe '#execute' do
      it "shows the failure count" do
        expect{ subject.execute script }.to output_approval :handler_failure
      end
    end

    describe '#failed' do
      before do
        expect{ subject.execute script }.to output_approval :handler_failure
      end
        
      it "returns the count of failed results" do
        expect(subject.failed).to eq 1
      end
    end

    describe '#failed?' do
      before do
        expect{ subject.execute script }.to output_approval :handler_failure
      end
        
      it "returns true" do
        expect(subject.failed?).to be true
      end
    end
  end
end
