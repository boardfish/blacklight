# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'escape_games/edit', type: :view do
  before(:each) do
    @escape_game = assign(:escape_game, EscapeGame.first)
  end

  it 'renders the edit escape_game form' do
    render

    assert_select(
      'form[action=?][method=?]', escape_game_path(@escape_game), 'post'
    ) do
    end
  end
end
