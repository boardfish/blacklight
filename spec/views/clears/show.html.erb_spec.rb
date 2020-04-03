# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'clears/show', type: :view do
  before(:each) do
    @clear = assign(:clear, create(:clear))
  end

  it 'renders attributes in <p>' do
    render
  end
end
