# == Schema Information
#
# Table name: link_subs
#
#  id         :integer          not null, primary key
#  link_id    :integer
#  sub_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe LinkSub do

  describe 'basice validations' do
    subject(:linksub) { FactoryGirl.create(:link_sub)}

    it 'should require link id' do
      linksub.link_id = nil
      should_not be_valid
    end

    it 'should require sub id' do
      linksub.sub_id = nil
      should_not be_valid
    end

    it 'should not allow duplicate link/sub id pairs' do
      dup_link = linksub.link_id
      dup_sub = linksub.sub_id
      duplicate = LinkSub.new(:link_id => dup_link, :sub_id => dup_sub)
      expect(duplicate).not_to be_valid
    end

    it "should be valid with a uniqe link/sub id pair" do
      should be_valid
    end
  end
end
