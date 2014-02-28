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

class User < ActiveRecord::Base
  attr_reader :password

  validates :email, :password_digest, :username, :session_token, presence: true
  validates :password, :length => { :minimum => 6, :allow_nil => true }
  before_validation :ensure_session_token

  has_many  :subs,
            :primary_key => :id,
            :foreign_key => :mod_id,
            :class_name => "Sub",
            inverse_of: :mod

  has_many :links, inverse_of: :user

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(params)
    user = User.find_by(username: params[:user]) || User.find_by(email: params[:user])
    return nil unless user
    user.is_password?(params[:password]) ? user : nil
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end


  private

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
