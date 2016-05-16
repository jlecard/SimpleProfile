require 'spec_helper'

describe Profile do
  before :all do
    @profile = Factory(:profile, :statuses=>[Factory(:status)], :user=>Factory(:user))
    @profile.save
    @profile.should be_valid
    @profile.should be_an_instance_of(Profile)
    @profile.city.should == "Paris"
    @profile.user.should be_an_instance_of(User)
    @profile.user.first_name.should == "John"
    @profile.statuses.should be_an_instance_of(Array)
    @profile.statuses.last.should be_an_instance_of(Status)
  end
  
  after :all do
    User.find(:all).each do |u|
      u.destroy
    end
    Status.find(:all).each do |s|
      s.destroy
    end
    @profile.destroy
  end

  describe ".last_status_message" do
    it "should be as expected" do
      @profile.last_status_message.should == "Mon statut"
    end
  end

  describe "last_statuses" do
    it "should be as expected" do
      @profile.last_statuses(1).should be_an_instance_of(Array)
      @profile.last_statuses(1).count.should be == 1
      @profile.last_statuses(10).should be_an_instance_of(Array)
      @profile.last_statuses(10).count.should be == 1
      @profile.statuses = [Factory(:status, :message=>"test1"),Factory(:status, :message=>"test2"),Factory(:status, :message=>"test3"),Factory(:status, :message=>"test4")]
      @profile.save
      @profile.reload  
      @profile.last_statuses(10).should be_an_instance_of(Array)
      @profile.last_statuses(10).count.should be == 4
      @profile.last_statuses(10)[0].message.should be == "test4"  
      @profile.last_statuses(10)[3].message.should be == "test1" 
    end
  end
  
  describe "gmaps4rails_address" do
    it "should default" do
      @profile.gmaps4rails_address.should == ", Paris, , France"
    end
  end
  
  describe "gmaps4rails_infowindow" do
    it "should show html" do
      id = @profile.id
      expected = "<h2>John, Doe</h2><br>"
      expected += "<a href=\"/profiles/#{id}\">Voir le profil</a>"
      @profile.gmaps4rails_infowindow.should == expected
    end
  end
  
  describe "geocoding" do
    it "should populate longitued and latitude fields" do
      @profile.latitude.should == 48.8566
      @profile.longitude.should == 2.35222
    end
    
  end
end

