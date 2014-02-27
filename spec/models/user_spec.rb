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

require 'spec_helper'

describe User do

  describe "Basic validations" do
    subject(:u) { FactoryGirl.build(:user) }

    it "requires a username" do
      user = FactoryGirl.build(:user, :username => nil)
      user.should_not be_valid
    end

    it "requires an email" do
      u.email = nil
      should_not be_valid
    end

    it "requires a password digest" do
      u.password_digest = nil
      should_not be_valid
    end

    it "is valid when all fields are present" do
      should be_valid
    end

    it "requires a password to be more than 6 characters" do
      u.password = 'dogie'
      should_not be_valid
    end

    it "allows a password to be nil" do
      should be_valid
    end
   end

   describe "password" do
     subject(:u) { FactoryGirl.build(:user) }

     it "responds to password method" do
       should respond_to(:password)
     end

     it "accepts a password" do
       u.password = 'foobar'
       expect(u.password).to eq 'foobar'
     end

     it "encrypts a password" do
       u.password = 'foobar'
       encrypted_password = BCrypt::Password.create(u.password)
       expect(BCrypt::Password.new(u.password_digest).is_password?(u.password)).to be_true
     end

     it "does not store a password" do
       u.save!
       user = User.first
       expect(user.password).to be_nil
     end

     it "matches a correct password" do
       u.password = 'foobar'
       expect(u.is_password?(u.password)).to be_true
     end

     it "does not match an incorrect password" do
       u.password = 'foobar'
       expect(u.is_password?('randomcrap')).to be_false
     end

   end

   describe "session_token" do
     subject(:u) { FactoryGirl.build(:user) }

     it "should ensure a session token before validations" do
       u.session_token = nil
       u.save!
       expect(User.first.session_token).to_not be_nil
     end

     describe "generate session_token" do

       it "should generate a random string" do
         token = User.generate_session_token
         token2 = User.generate_session_token
         expect(token.is_a?(String)).to be_true
         expect(token).to_not eq token2
       end
     end

   end

end
