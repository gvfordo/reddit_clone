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

require 'spec_helper'
require 'debugger'
describe Sub do

  subject(:sub) { FactoryGirl.create(:sub) }
  it 'should have a mod_id' do
    expect(sub.mod_id).to_not be_nil
  end

  it 'should fail without a name' do
    sub.name = nil
    should_not be_valid
  end

  it 'should belong to a user' do
    expect(sub.mod.is_a?(User)).to be_true
  end

  it "should not have any link subs" do
    expect(sub.link_subs.length).to eq 0
  end

  it "can have many link subs" do
    sub_with_links = FactoryGirl.create(:sub_with_link_subs)
    expect(sub_with_links.link_subs.length).to eq 5
  end

  it "can have many links" do
    sub = FactoryGirl.create(:sub_with_links)
    expect(sub.links.length).to eq 5
  end


end
