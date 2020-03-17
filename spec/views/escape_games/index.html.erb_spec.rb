# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'escape_games/index', type: :view do
  before(:each) do
    assign(:escape_games, [
             EscapeGame.first
           ])
  end

  it 'renders a list of escape_games' do
    render
  end
end
