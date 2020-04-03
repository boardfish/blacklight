# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'clears/index', type: :view do
  before(:each) do
    assign(:clears, [
             create(:clear),
             create(:clear)
           ])
  end

  it 'renders a list of clears' do
    render
  end
end
