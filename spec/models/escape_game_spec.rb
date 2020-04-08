# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EscapeGame, type: :model do
  before(:all) do
    @escape_game = create(:escape_game)
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
      filename: 'first_image.png',
      content_type: 'image/png'
    )
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
      filename: 'second_image.png',
      content_type: 'image/png'
    )
    @escape_game.reload
  end

  it 'returns the first image on the model when unset' do
    expect(@escape_game.default_image.filename).to(
      eq(@escape_game.images.first.filename)
    )
  end

  it 'returns the second image on the model when set' do
    @escape_game.default_image = @escape_game.images.last.signed_id
    @escape_game.save
    @escape_game.reload
    expect(@escape_game.default_image.filename).to eq(
      @escape_game.images.last.filename
    )
  end
  # create instance
  # attach two images
  # check that default_image returns first image when unset
  # set
  # check that default_image returns second image now that it's set
end
