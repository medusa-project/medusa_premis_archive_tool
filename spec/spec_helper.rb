# This file is copied to spec/ when you run 'rails generate rspec:install'
# ENV["RAILS_ENV"] ||= 'test'
# require File.expand_path("../../config/environment", __FILE__)
# require 'rspec/rails'
# require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
# Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

# require 'rubygems'
# require 'bundler/setup'
# require 'devise'
require 'medusa-premis-archive-tool'

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  # config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  # config.order = "random"

  # Devise helper
  # config.include Devise::TestHelpers, :type => :controller
 
       
  # Ths code is here so we can load xml files from the spec/fixtures directory
  # def fixture(file)
  #   File.new(File.join(File.dirname(__FILE__), 'fixtures', file))
  # end

end

def test_attribute_xpath(datastream, name, xpath, value='blah')
   datastream.send(name.to_s+'=', value)
#  datastream.send(name).should == [value]
#  Cannot use above statement because of possible, multiple ocurrences of <name>
   (datastream.send(name))[0].should == value
   datastream.send(name).xpath.should == xpath
end

def test_existing_attribute(datastream, name, value='blah')
   datastream.send(name).should == [value]
end

def test_existing_attribute_nth_occurence(datastream, n, name, value='blah')
   (datastream.send(name))[n-1].should == value
end

def test_existing_attribute_multiple_occurence(datastream, name, value='blah')
   (datastream.send(name)).should == value
end
