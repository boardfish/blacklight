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
end
