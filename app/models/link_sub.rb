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

class LinkSub < ActiveRecord::Base
  validates :link, :sub, :presence => true
  validates :link, :uniqueness => { :scope => :sub }

  belongs_to :link, inverse_of: :link_subs
  belongs_to :sub, inverse_of: :link_subs
end
