require 'spec_helper'

describe Handler do
  describe '#execute' do
    let(:script) { 'spec/scripts/basic.rb' }

    it "runs the script" do
      expect{ subject.execute script }.to output_fixture('basic')
    end

    context "when the script has a failure" do
      let(:script) { 'spec/scripts/failure.rb' }
      
      it "shows the failure count" do
        expect{ subject.execute script }.to output_fixture('failure')
      end
    end
  end
end
