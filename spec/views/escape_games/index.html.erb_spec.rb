# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'escape_games/index', type: :view do
  before(:each) do
    assign(:escape_games,
           if EscapeGame.all.count > 0
             EscapeGame.all
           else
             [create(:escape_game)]
           end)
  end

  it 'renders a list of escape_games' do
    render
  end
end
