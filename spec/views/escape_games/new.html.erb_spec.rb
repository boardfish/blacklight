# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'escape_games/new', type: :view do
  before(:each) do
    assign(:escape_game, EscapeGame.new)
  end

  it 'renders new escape_game form' do
    render

    assert_select 'form[action=?][method=?]', escape_games_path, 'post' do
    end
  end
end
