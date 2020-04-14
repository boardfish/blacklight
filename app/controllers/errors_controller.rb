# frozen_string_literal: true

# Controller for displaying custom error messages
# https://stackoverflow.com/a/26286472
class ErrorsController < ApplicationController
  FLASH_CONTENT = {
    404 => "You're looking lost there. That route doesn't exist, sorry!",
    422 => 'Struggling to process that one, sorry...',
    500 => "Something's up on our end - sorry about that!",
    503 => "Something's up on our end - sorry about that!"
  }.freeze

  def show
    @status_code = params[:code] || 500
    flash.alert = {
      title: "Error #{@status_code}",
      content: FLASH_CONTENT[@status_code.to_i]
    }
  end
end
