# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'escape_games/show', type: :view do
  before(:each) do
    assign(:escape_game, create(:escape_game))
  end

  xit 'renders attributes in <p>' do
    render
  end
end
