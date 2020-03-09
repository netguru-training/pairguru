require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:users) { create_list(:user, 9) }

  describe '#top_commenters' do
    it 'returns no users and renders template' do
      allow_any_instance_of(Users::Queries::TopCommenters).to receive(:call).and_return(users)

      expect(get :top_commenters).to render_template(:top_commenters)
      expect(assigns(:top_commenters)).to eq users
    end
  end
end
