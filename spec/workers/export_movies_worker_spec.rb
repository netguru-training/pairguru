
require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe ExportMoviesWorker, type: :worker do
  let(:user)                  { create(:user) }
  let(:file_path)             { 'tmp/movies.csv' }
  let(:scheduled_valid_job)   { described_class.new.perform(user.id, file_path) }
  let(:scheduled_invalid_job) { described_class.new.perform(user.id + 1, file_path) }

  describe '#perform' do
    context 'when user is present' do
      it 'enqueues MovieExporter call' do
        expect(MovieExporter).to receive(:call)
                             .with(user, file_path)

        scheduled_valid_job
      end
    end

    context 'when user is absent' do
      it 'raises ActiveRecord::RecordNotFound error' do
        expect { scheduled_invalid_job }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
