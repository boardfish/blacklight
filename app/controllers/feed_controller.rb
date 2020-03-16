# frozen_string_literal: true

# Controller for the user's feeds.
class FeedController < ApplicationController
  before_action :authenticate_user!

  def show; end
end
