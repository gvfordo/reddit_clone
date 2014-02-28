# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  title      :string(255)      not null
#  url        :string(1024)     not null
#  link_text  :text
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :link do
    title Faker::Lorem.words(20).join(" ")
    url Faker::Internet.url
    user

    factory :link_with_subs do
      title Faker::Lorem.words(20).join(" ")
      url Faker::Internet.url
      user

      after(:create) do |link|
        create_list(:link_sub, 5, link: link)
      end
    end
  end
end
