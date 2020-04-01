# frozen_string_literal: true

json.extract! clear, :id, :created_at, :updated_at
json.url clear_url(clear, format: :json)
