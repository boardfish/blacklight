# frozen_string_literal: true

require 'yaml'
require 'uri'
require 'nokogiri'
require 'open-uri'
require 'cgi'
stages = YAML.load_file('scraper-data.yml')['fighter']

WEB_ROOT = 'https://www.ssbwiki.com'

def get_image_page_link(char_name, filetype)
  "#{WEB_ROOT}/File:#{CGI.escape(char_name.tr(' ', '').tr('.', ''))}HeadSSBUWebsite.#{filetype}"
end

def get_direct_image_link(stage_name)
  @doc = Nokogiri::HTML(
    URI.open(get_image_page_link(stage_name, 'png')), &:nononet
  )
  URI(
    "#{WEB_ROOT}#{@doc.at_css('div.fullMedia a.internal').attributes['href']}"
  )
rescue OpenURI::HTTPError
  puts "An error was reported for #{stage_name}."
  ''
end

def download_image(link)
  URI.open(link) do |image|
    File.open("./avatars/#{link.path.to_s.split('/')[-1]}", 'wb') do |file|
      file.write(image.read)
    end
  end
end

stages.each do |stage_name|
  link = get_direct_image_link(stage_name)
  download_image(link) unless link == ''
end
