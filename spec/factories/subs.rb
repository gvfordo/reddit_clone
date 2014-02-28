# == Schema Information
#
# Table name: subs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  mod_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'
require 'debugger'
FactoryGirl.define do
  factory :sub do
    name Faker::Lorem.words(3).join(" ")
    association :mod, factory: :user

    factory :sub_with_link_subs do
      name Faker::Lorem.words(3).join(" ")
      association :mod, factory: :user

      after(:create) do |sub|
        create_list(:link_sub, 5, sub: sub)
      end
    end

    factory :sub_with_links do
      name Faker::Lorem.words(3).join(" ")
      association :mod, factory: :user

      after(:create) do |sub|
        5.times { sub.links << FactoryGirl.create(:link) }
      end
    end
  end
end

