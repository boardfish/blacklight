# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'escape_games/show', type: :view do
  before(:each) do
    @escape_game = assign(:escape_game, EscapeGame.first)
  end

  it 'renders attributes in <p>' do
    render
  end
end
