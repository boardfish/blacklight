# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe EscapeGamesController, type: :controller do
  before(:all) do
    @escape_game = create(:escape_game)
    @user = @escape_game.user
  end

  before(:each) do
    sign_in @user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: @escape_game.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: @escape_game.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new EscapeGame' do
        expect do
          post :create, params: { escape_game: attributes_for(:escape_game) }
        end.to change(EscapeGame, :count).by(1)
      end

      it 'redirects to the created escape_game' do
        post :create, params: { escape_game: attributes_for(:escape_game) }
        expect(response).to redirect_to(EscapeGame.last)
      end
    end

    context 'with invalid params' do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create,
             params: {
               escape_game: attributes_for(:escape_game).merge(name: '')
             }
        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        attributes_for(:escape_game)
      end

      it 'updates the requested escape_game' do
        escape_game = @escape_game
        put :update, params: {
          id: escape_game.to_param,
          escape_game: new_attributes
        }
        escape_game.reload
        expect(@escape_game.name).to eq(new_attributes[:name])
      end

      it 'redirects to the escape_game' do
        escape_game = @escape_game
        put :update, params: {
          id: escape_game.to_param,
          escape_game: new_attributes
        }
        expect(response).to redirect_to(escape_game)
      end

      it 'does not change the associated user ID' do
        escape_game = @escape_game
        owner = @escape_game.user
        attacking_user = if User.all.count < 2
                           create(:user)
                         else
                           users = User.all
                           users -= [owner]
                           users.sample
                         end
        put :update, params: {
          id: escape_game.to_param,
          escape_game: attributes_for(:escape_game).merge(user: attacking_user)
        }
        escape_game.reload
        expect(@escape_game.user).to eq(owner)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) do
        attributes_for(:escape_game).merge(name: '')
      end

      it "returns a success response (i.e. to display the 'edit' template)" do
        escape_game = @escape_game
        put :update, params: {
          id: escape_game.to_param,
          escape_game: invalid_attributes
        }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'discards the requested escape_game' do
      escape_game = @escape_game
      full_count = EscapeGame.count
      expect do
        delete :destroy, params: { id: escape_game.to_param }
      end.to change(EscapeGame.kept, :count).by(-1)
      expect(full_count).to eq(EscapeGame.count)
    end

    it 'redirects to the escape_games list' do
      escape_game = @escape_game
      delete :destroy, params: { id: escape_game.to_param }
      expect(response).to redirect_to(escape_games_url)
    end
  end
end
