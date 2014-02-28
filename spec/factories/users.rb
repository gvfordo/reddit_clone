# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  email           :string(255)
#  session_token   :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
require 'debugger'
FactoryGirl.define do
  factory :user do
    username Faker::Internet.user_name
    email Faker::Internet.email
    session_token "awneoflhjs9d8fa"
    password_digest "welfjkasf98seflkw3nflksdhiosdnlkfgwenj"

    factory :user_with_subs do
      username Faker::Internet.user_name
      email Faker::Internet.email
      session_token "awneoflhjs9d8fa"
      password_digest "welfjkasf98seflkw3nflksdhiosdnlkfgwenj"

      after(:create) do |user|
        create_list(:sub, 5, mod: user)
      end
    end

    factory :user_with_links do
      username Faker::Internet.user_name
      email Faker::Internet.email
      session_token "awneoflhjs9d8fa"
      password_digest "welfjkasf98seflkw3nflksdhiosdnlkfgwenj"

      after(:create) do |user|
        create_list(:link, 5, user: user)
      end
    end
  end


end



