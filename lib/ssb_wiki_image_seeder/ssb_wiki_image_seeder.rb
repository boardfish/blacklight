# frozen_string_literal: true

require 'yaml'
require 'uri'
require 'nokogiri'
require 'open-uri'
require 'cgi'

# Retrieves images from SSBWiki for use during seeding.
class SSBWikiImageSeeder
  WEB_ROOT = 'https://www.ssbwiki.com'

  def initialize(image_link_template_string)
    @image_link_template_string = image_link_template_string
  end

  def get_image_page_link(stage_name, filetype)
    format(
      @image_link_template_string,
      WEB_ROOT,
      CGI.escape(stage_name.tr(' ', '_').tr('.', '')), filetype
    )
  end

  def get_direct_image_link(stage_name, filetype)
    @doc = Nokogiri::HTML(
      URI.open(get_image_page_link(stage_name, filetype)), &:nononet
    )
    URI(
      "#{WEB_ROOT}#{@doc.at_css('div.fullMedia a.internal').attributes['href']}"
    )
  rescue OpenURI::HTTPError
    ''
  end

  def get_direct_link_any_type(stage_name)
    return nil if ENV['CI']

    png_link = get_direct_image_link(stage_name, 'png')
    jpg_link = get_direct_image_link(stage_name, 'jpg')
    [png_link, jpg_link].reject { |link| link.to_s.empty? }.first
  end

  def download_image(stage_name)
    link = get_direct_link_any_type(stage_name)
    return if link.to_s.empty?

    URI.open(link, &:read)
  end
end
