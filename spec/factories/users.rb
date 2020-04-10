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
      image_to_attach = File.open(
        Rails.root.join(
          'spec',
          'fixtures',
          'files',
          'avatars',
          "#{CGI.escape(user.nickname.tr(' ', ''))}HeadSSBUWebsite.png"
        )
      )
      user.avatar.attach(
        io: image_to_attach,
        filename: "#{CGI.escape(user.nickname.tr(' ', ''))}HeadSSBUWebsite.png",
        content_type: 'image/png'
      )
    rescue Errno::ENOENT
    end
  end
end
