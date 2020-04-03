# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'clears/edit', type: :view do
  before(:each) do
    @clear = assign(:clear, create(:clear))
  end

  it 'renders the edit clear form' do
    render

    assert_select 'form[action=?][method=?]', clear_path(@clear), 'post' do
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
    @clear.images.attach(
      io: image_to_attach,
      filename: 'original_image.png',
      content_type: 'image/png'
    )
    render
    # Make sure there's a hidden field for the image that already exists on the
    # clear
    assert_select 'form[action=?][method=?]', clear_path(@clear), 'post' do
      assert_select 'input[multiple=multiple][type=hidden]' \
                    '[name=clear\[images\]\[\]]'
    end
  end
end
