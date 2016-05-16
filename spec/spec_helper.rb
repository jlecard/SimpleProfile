# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/mocks'
require 'rspec/autorun'
require 'factory_girl'
require 'authlogic/test_case'

include Authlogic::TestCase

#load 'factories.rb'
# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
# ## Mock Framework
#
# If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
#
# config.mock_with :mocha
# config.mock_with :flexmock
# config.mock_with :rr

# Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
  
  config.mock_with :rspec

end

def login_user(user, options = {})
  @logged_in_user = user
  @controller.stub!(:current_user).and_return(@logged_in_user)
  @logged_in_user
end

def login_setup
  activate_authlogic
  user = Factory.build(:user)
  user.save
  sleep(0.3)
  UserSession.create user
  @profile = Factory(:profile, :statuses=>[Factory(:status)], :user=>user)
  @profile.save
  login_user(user)
end


def logout
  @logged_in_user = nil
  @controller.stub!(:current_user).and_return(@logged_in_user)
  @logged_in_user
end

def set_http_referer(referer='http://test.host/profiles')
  @request.env['HTTP_REFERER'] = referer
end

def clear_data
  ActiveRecord::Base.connection.execute("truncate users;")
  ActiveRecord::Base.connection.execute("truncate profiles;")
  ActiveRecord::Base.connection.execute("truncate user_sessions;")
  ActiveRecord::Base.connection.execute("truncate statuses;")
end