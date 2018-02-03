require 'spec_helper'

describe 'bin/enforce' do
  subject { 'bin/enforce' }

  context "without arguments" do
    it "shows usage" do
      expect(`#{subject}`).to match /Usage:/
    end
  end

  context "with a script argument" do
    it "runs the script" do
      expect(`#{subject} basic`).to match_fixture :bin_1
    end
  end

  context "with an invalid script argument" do
    it "exits with a non-zero code" do
      expect(`#{subject} NoSuchScript`).to match_fixture :bin_2
      expect($?.exitstatus).to eq 1
    end
  end
end
