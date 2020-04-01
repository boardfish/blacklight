# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClearsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/clears').to route_to('clears#index')
    end

    it 'routes to #new' do
      expect(get: '/clears/new').to route_to('clears#new')
    end

    it 'routes to #show' do
      expect(get: '/clears/1').to route_to('clears#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/clears/1/edit').to route_to('clears#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/clears').to route_to('clears#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/clears/1').to route_to('clears#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/clears/1').to route_to('clears#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/clears/1').to route_to('clears#destroy', id: '1')
    end
  end
end
