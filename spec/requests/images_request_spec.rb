# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Images', type: :request do
  describe 'DELETE /escape_games/1/images/1' do
    it 'returns http success' do
      delete escape_game_image_path(1, 1)
      expect(response).to have_http_status(:success)
    end
  end
end
