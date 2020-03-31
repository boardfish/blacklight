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

  describe 'GET #explore' do
    it 'returns a success response' do
      get :explore
      expect(response).to be_successful
    end

    it 'does not show my escape rooms' do
      get :explore
      expect(
        assigns(:escape_games).filter do |game|
          game[:escape_game].user == @user
        end
      ).to be_empty
    end

    it 'filters escape rooms by name' do
      get :explore, params: { q: 'Mushroom' }
      puts assigns(:escape_games).map(&:name)
      expect(
        assigns(:escape_games).filter { |game| !game.name.include? 'Mushroom' }
      ).to be_empty
    end

    it 'filters escape rooms by difficulty' do
      get :explore, params: { difficulty: 'beginner' }
      expect(
        assigns(:escape_games).reject do |game|
          game[:difficulty_level] == 'beginner'
        end
      ).to be_empty
    end

    it 'filters escape rooms by both name and difficulty at once' do
      get :explore, params: { difficulty: 2, q: 'Mushroom' }
      puts assigns(:escape_games)
      expect(
        assigns(:escape_games).filter { |game| !game.name.include? 'Mushroom' }
      ).to be_empty
      expect(
        assigns(:escape_games).reject do |game|
          game[:difficulty_level] == 'enthusiast'
        end
      ).to be_empty
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

    it 'does not allow those that aren\'t the owner to access it' do
      sign_in random_user(owner: @user)
      expect do
        get :edit, params: { id: @escape_game.to_param }
      end.to raise_error ActiveRecord::RecordNotFound
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

      it 'does not allow a user to manipulate the owner on create' do
        user_signing_in = random_user
        sign_in user_signing_in
        expect do
          post :create,
               params: {
                 escape_game: attributes_for(:escape_game).merge(
                   user: random_user(owner: user_signing_in)
                 )
               }
        end.to change(EscapeGame, :count).by(1)
        expect(EscapeGame.last.user).to eq(user_signing_in)
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
        attacking_user = random_user(owner: owner)
        put :update, params: {
          id: escape_game.to_param,
          escape_game: attributes_for(:escape_game).merge(user: attacking_user)
        }
        escape_game.reload
        expect(@escape_game.user).to eq(owner)
      end

      it 'does not allow those that aren\'t the owner to update it' do
        sign_in random_user(owner: @user)
        expect do
          put :update, params: {
            id: @escape_game.to_param,
            escape_game: attributes_for(:escape_game)
          }
        end.to raise_error ActiveRecord::RecordNotFound
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

    it 'does not allow those that aren\'t the owner to destroy it' do
      sign_in random_user(owner: @user)
      expect do
        delete :destroy, params: { id: @escape_game.to_param }
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'POST #cleared' do
    it 'creates a Clear' do
      visitor = random_user(owner: @escape_game.user)
      sign_in visitor
      expect do
        put :cleared, params: { id: @escape_game.to_param, cleared: true }
      end.to change(Clear, :count).by(1)
    end

    it 'creates a Clear containing the logged-in user' do
      visitor = random_user(owner: @escape_game.user)
      sign_in visitor
      put :cleared, params: { id: @escape_game.to_param, cleared: true }
      expect(Clear.last.user).to eq(visitor)
      expect(Clear.last.escape_game).to eq(@escape_game)
    end
  end
end
