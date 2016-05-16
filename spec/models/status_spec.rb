require 'spec_helper'

describe Status do
  describe "create" do
    it "should be valid" do
      status = Factory(:status,:profile=>Factory(:profile))
      status.save
      status.should be_valid
      status.message.should == "Mon statut"
      status.profile.should be_an_instance_of(Profile)
    end
  end
end

