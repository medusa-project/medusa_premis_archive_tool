require 'spec_helper'

describe MedusaPremis::Event do

   before do
      Event.find_each{|e| e.delete}
   end
   # before do
   #    a = event.create
   # end

   it "should have an identifierType" do
     subject.identifierType = "test_local"
     subject.identifierType.should == "test_local"
   end

end

