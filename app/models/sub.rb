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

class Sub < ActiveRecord::Base
  validates :name, :mod, :presence => true

  belongs_to  :mod,
              :primary_key => :id,
              :foreign_key => :mod_id,
              :class_name => "User"


  has_many :link_subs, inverse_of: :sub

  has_many :links, :through => :link_subs, :source => :link

end
