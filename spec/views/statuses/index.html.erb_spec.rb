require 'spec_helper'

describe "statuses/index" do
  before(:each) do
    @user = login_setup
    assign(:statuses, [

      stub_model(Status,

        :message => "Message",
        :profile => @profile

      ),

      stub_model(Status,

        :message => "Message",

         :profile => @profile

      )

    ])
  end

  it "renders a list of statuses" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers

    assert_select "tr>td", :text => "Message".to_s, :count => 2

    assert_select "tr>td", :text => "".to_s, :count => 2

  end
end
