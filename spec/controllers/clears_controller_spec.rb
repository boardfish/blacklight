# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClearsController, type: :controller do
  before(:each) do
    @clear = create(:clear)
  end

  it 'does not allow users to edit others\' clears' do
    clear = @clear
    attacking_user = random_user(owner: @clear.user)
    sign_in attacking_user
    expect {
      put :update, params: {
        id: clear.to_param,
        clear: attributes_for(:clear).merge(user: attacking_user)
      }
    }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'does not allow users to delete others\' clears' do
    clear = @clear
    attacking_user = random_user(owner: @clear.user)
    sign_in attacking_user
    expect {
      delete :destroy, params: {
        id: clear.to_param
      }
    }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
