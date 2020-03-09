require 'rails_helper'

RSpec.describe Movies::SimpleSerializer do
  let(:movie_1)       { create(:movie) }
  let(:serializer)    { described_class.new(movie_1) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  subject { JSON.parse(serialization.to_json) }

  let(:movie_hash) do
    {
      'id' => movie_1.id,
      'title' => movie_1.title
    }
  end

  context 'for single movie' do
    it 'returns movie hash' do
      expect(subject).to eq(movie_hash)
    end
  end
end
