
require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe SendMovieInfoWorker, type: :worker do
  let(:user)                  { create(:user) }
  let(:movie)                 { create(:movie) }
  let(:scheduled_valid_job)   { described_class.new.perform(user.id, movie.id) }
  let(:scheduled_invalid_job) { described_class.new.perform(user.id + 1, movie.id) }

  describe '#perform' do
    context 'when user is present' do
      it 'enqueues MovieInfoMailer call' do
        expect(MovieInfoMailer).to receive(:send_info)
                               .with(user, movie)

        scheduled_valid_job
      end
    end

    context 'when user or movie is absent' do
      it 'raises ActiveRecord::RecordNotFound error' do
        expect { scheduled_invalid_job }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
