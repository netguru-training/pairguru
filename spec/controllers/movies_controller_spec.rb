require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  let!(:user)    { create(:user) }
  let!(:movie)   { create(:movie) }
  let!(:comment) { create(:comment, movie: movie) }
  before { sign_in(user) }
  let!(:movie_struct) do
    struct = Struct.new(
      :id,
      :title,
      :released_at,
      :genre_id,
      :genre_name,
      :created_at,
      :updated_at,
      :description,
      :avatar,
      :rating
    )

    struct.new(
      id: movie.id,
      title: movie.title,
      released_at: movie.released_at,
      genre_id: movie.genre_id,
      genre_name: movie.genre.name,
      created_at: movie.created_at,
      updated_at: movie.updated_at,
      description: movie.description,
      avatar: nil,
      rating: 9.2
    )
  end

  describe 'GET index' do
    it 'assigns movies and movies_list to @movies and @movies_list' do
      allow_any_instance_of(ImportData).to receive(:call).and_return([movie_struct])

      get :index
      expect(assigns(:movies_list)).to eq([movie])
      expect(assigns(:movies)).to eq([movie_struct])
    end

    it 'renders index template' do
      allow_any_instance_of(ImportData).to receive(:call).and_return([movie_struct])

      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    context 'when movie is present' do
      it 'assigns @movie, @comment, @comments and renders show template' do
        allow_any_instance_of(ImportData).to receive(:call).and_return([movie_struct])

        get :show, params: { id: movie.id }
        expect(assigns(:movie)).to eq(movie_struct)
        expect(assigns(:comment)).to be_an_instance_of(Comment)
        expect(assigns(:comments)).to eq([comment])
        expect(response).to render_template(:show)
      end
    end

    context 'when movie is absent' do
      it 'redirects to root path' do
        get :show, params: { id: movie.id + 1 }

        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET send_info' do
    context 'when movie is present' do
      it 'redirects to root path' do
        allow_any_instance_of(ExportMoviesWorker).to receive(:perform)

        get :send_info, params: { id: movie.id }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when movie is absent' do
      it 'redirects to root path with notice' do
        allow_any_instance_of(ExportMoviesWorker).to receive(:perform)

        get :send_info, params: { id: movie.id + 1 }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET export' do
    it 'redirects to root path with notice' do
      allow_any_instance_of(ExportMoviesWorker).to receive(:perform)

      get :export
      expect(response).to redirect_to(root_path)
    end
  end
end
