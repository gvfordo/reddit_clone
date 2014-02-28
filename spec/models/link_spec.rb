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

require 'spec_helper'

describe Link do

  describe "basic validation" do

    subject(:link) { FactoryGirl.create(:link) }

    it "should have a user_id" do
      link.user_id = nil
      should_not be_valid
    end

    it "should have a title" do
      link.title = nil
      should_not be_valid
    end

    it "should have a URL" do
      link.url = nil
      should_not be_valid
    end

    it "should not require link_text" do
      link.link_text = nil
      should be_valid
    end

    it "should be valid with user_id, title, and URL" do
      should be_valid
    end

    it "link belongs to a user" do
      expect(link.user.is_a?(User)).to be_true
    end

    it "should not have any link_subs" do
      expect(link.link_subs.length).to eq 0
    end

    it "should have many link_subs" do
      link_with_subs = FactoryGirl.create(:link_with_subs)
      expect(link_with_subs.link_subs.length).to eq 5
    end
  end
end
