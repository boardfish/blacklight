# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'EscapeGames', type: :request do
  describe 'GET /escape_games' do
    it 'redirects when the user is not signed in' do
      get escape_games_path
      expect(response).to have_http_status(302)
    end
  end
end
