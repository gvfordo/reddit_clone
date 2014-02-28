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

class Link < ActiveRecord::Base
  validates :user, :url, :title, presence: true

  belongs_to :user, inverse_of: :links

  has_many :link_subs, inverse_of: :link

  has_many :subs, :through => :link_subs, :source => :sub
end
