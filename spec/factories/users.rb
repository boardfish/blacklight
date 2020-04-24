# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    nickname { Faker::Games::SuperSmashBros.unique.fighter.tr(' ', '') }
    maintainer { [true, false].sample }
    enthusiast { [true, false].sample }

    public { true }

    website { 'https://simon.fish' }

    after(:build) do |user|
      image_link = SSBWikiImageSeeder.new('%s/File:%sHeadSSBUWebsite.%s')
                                     .get_direct_link_any_type(user.nickname)
      # can't return
      if image_link
        user.avatar.attach(
          io: image_link.open,
          filename: "SSBU-#{CGI.escape(user.nickname.tr(' ', '_'))}.png",
          content_type: 'image/png'
        )
      end
    rescue Errno::ENOENT
    end
  end
end
