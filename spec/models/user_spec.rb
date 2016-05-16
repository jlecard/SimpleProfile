require 'spec_helper'

describe User do
  before :all do
    @user = Factory(:user)
    @user.save
  end
  
  after :all do
    @user.destroy
  end
  
  describe "valid" do
    it "should be be valid" do
      @user.should be_valid
    end
  end

  describe "crypted password" do
    it "should be set" do
      @user.crypted_password.should_not == "toto"
    end
  end

  describe "full name" do
    it "should be John Doe" do
      @user.full_name.should == "John Doe"
    end
  end
  describe "last login not set" do
    it "should be John Doe" do
      @user.last_login.should be_nil
    end
  end
end
