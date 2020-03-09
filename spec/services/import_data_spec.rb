require 'rails_helper'

RSpec.describe ImportData do
  let(:importer)  { double(:importer, call: 'Imported data') }
  let(:organizer) { double(:organizer, call: 'Organized data') }
  let!(:movie)    { build(:movie) }
  subject { described_class.new(importer, organizer).call([movie], [movie.title]) }

  describe '#call' do
    it "calls importer and organizer" do
      expect(importer).to receive(:call).with([movie.title])
      expect(organizer).to receive(:call).with([movie], 'Imported data')
      expect(subject).to eq('Organized data')
    end
  end
end
