# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'clears/new', type: :view do
  before(:each) do
    assign(:clear, Clear.new)
  end

  it 'renders new clear form' do
    render

    assert_select 'form[action=?][method=?]', clears_path, 'post' do
    end
  end
end
