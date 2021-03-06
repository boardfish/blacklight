# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImagesController, type: :controller do
  before(:all) do
    @escape_game = create(:escape_game)
    @user = @escape_game.user
    image_to_attach = File.open(
      Rails.root.join(
        'spec',
        'fixtures',
        'files',
        '100.png'
      )
    )
    @escape_game.images.attach(
      io: image_to_attach,
      filename: 'first_image.png',
      content_type: 'image/png'
    )
  end

  it 'removes an image from an escape game' do
    # byebug
    expect do
      delete :destroy, params: {
        escape_game_id: @escape_game.id, id: @escape_game.images.last.id
      }
    end.to change { @escape_game.images.count }.by(-1)
  end
end
