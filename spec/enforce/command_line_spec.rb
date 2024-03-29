describe CommandLine do
  subject { described_class }

  describe '#execute' do
    context 'without arguments' do
      it 'shows usage' do
        expect { subject.execute }.to output(/Usage:/).to_stdout
      end
    end

    context 'with a file that does not exist' do
      it 'fails gracefully' do
        expect { subject.execute ['NoSuchFile'] }.to output_approval :cli_execute1
      end
    end

    context 'with an existing file' do
      it 'runs the script' do
        expect { subject.execute ['basic'] }.to output_approval :cli_execute2
      end
    end
  end
end
