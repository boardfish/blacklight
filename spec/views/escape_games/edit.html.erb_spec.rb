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

  it 'doesn\'t overwrite files on update' do
    # Attach an image so one already exists.
    image_to_attach = File.open(
      Rails.root.join(
        'spec',
        'fixtures',
        'files',
        'escape_game',
        'SSBU-Big_Blue.png'
      )
    )
    @escape_game.images.attach(
      io: image_to_attach,
      filename: 'original_image.png',
      content_type: 'image/png'
    )
    render
    # Make sure there's a hidden field for the image that already exists on the
    # escape game
    assert_select 'form[action=?][method=?]',
                  escape_game_path(@escape_game), 'post' do
      assert_select 'input[multiple=multiple][type=hidden]' \
                    '[name=escape_game\[images\]\[\]]'
    end
  end
end
