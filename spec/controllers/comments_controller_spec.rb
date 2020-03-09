require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:user)  { create(:user) }
  let(:movie)  { create(:movie) }
  before { sign_in(user) }

  describe 'POST create' do
    let(:valid_params) do
      {
        movie_id: movie.id,
        comment: {
          description: Faker::Lorem.sentence(3, true),
          movie_id: movie.id,
          user_id: user.id
        }
      }
    end

    let(:invalid_params) do
      {
        movie_id: movie.id,
        comment: {
          description: nil,
          movie_id: movie.id,
          user_id: user.id
        }
      }
    end

    context 'with valid params' do
      it 'creates comment and redirects to movie path' do
        expect { post :create, params: valid_params }.to change { Comment.count }.by(1)
        expect(response).to redirect_to(movie_path(movie.id))
      end
    end

    context 'with invalid params' do
      it "doesn't create comment and redirects to movie path" do
        expect { post :create, params: invalid_params }.to change { Comment.count }.by(0)
        expect(response).to redirect_to(movie_path(movie.id))
      end
    end
  end

  describe 'GET edit' do
    let!(:comment) { create(:comment) }

    context 'when comment is present' do
      it 'assigns the requested comment as @comment and renders edit template' do
        params = {
          movie_id: movie.id,
          id: comment.id,
          comment: {
            description: Faker::Lorem.sentence(3, true),
            movie_id: movie.id,
            user_id: user.id
          }
        }

        get :edit, params: params
        expect(response).to render_template(:edit)
        expect(assigns(:comment)).to eq(comment)
      end
    end

    context 'when comment is absent' do
      it 'redirects to root path and displayes alert message' do
        params = {
          movie_id: movie.id,
          id: comment.id + 1,
          comment: {
            description: Faker::Lorem.sentence(3, true),
            movie_id: movie.id,
            user_id: user.id
          }
        }

        get :edit, params: params
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PUT update' do
    let!(:comment) { create(:comment, description: 'Comment description', movie: movie, user: user) }
    let(:update_valid_params) do
      {
        movie_id: movie.id,
        id: comment.id,
        comment: {
          description: 'Updated comment description',
          movie_id: movie.id,
          user_id: user.id
        }
      }
    end

    let(:update_invalid_params) do
      {
        movie_id: movie.id,
        id: comment.id,
        comment: {
          description: nil,
          movie_id: movie.id,
          user_id: user.id
        }
      }
    end

    let(:unexisting_comment_params) do
      {
        movie_id: movie.id,
        id: comment.id + 1,
        comment: {
          description: 'Updated comment description',
          movie_id: movie.id,
          user_id: user.id
        }
      }
    end

    context 'when comment is present' do
      context 'with valid params' do
        it 'updates comment and redirects to movie path' do
          put :update, params: update_valid_params

          expect(response).to redirect_to(movie_path(comment.movie_id))
          expect(comment.reload.description).to eq('Updated comment description')
        end
      end

      context 'with invalid params' do
        it "doesn't update comment and renders edit template" do
          put :update, params: update_invalid_params

          expect(response).to render_template(:edit)
          expect(comment.reload.description).to eq('Comment description')
        end
      end
    end

    context 'when comment is absent' do
      it 'redirects to root path' do
        put :update, params: unexisting_comment_params

        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:comment) { create(:comment, movie: movie) }
    let(:params)  do
      {
        movie_id: movie.id,
        id: comment.id
      }
    end

    let(:invalid_params)  do
      {
        movie_id: movie.id,
        id: comment.id + 1
      }
    end

    context 'when comment is present' do
      it 'destroyes the requested comment and redirects to movie path' do
        expect { delete :destroy, params: params }.to change { Comment.count }.by(-1)
        expect(response).to redirect_to(movie_path(movie.id))
      end
    end

    context 'when comment is absent' do
      it 'redirects to root path and displayes alert message' do
        delete :destroy, params: invalid_params

        expect(response).to redirect_to(root_path)
      end
    end
  end
end
