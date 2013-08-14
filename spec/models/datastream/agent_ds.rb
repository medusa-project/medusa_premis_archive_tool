require 'spec_helper'

describe MedusaPremis::Datastream::AgentDs do
   describe "with new datastream" do
      before do
         @datastream = MedusaPremis::Datastream::AgentDs.new(nil,'Premis-Agent')
      end
      it "should have identifier" do
         test_attribute_xpath(@datastream, 'identifier', "//oxns:agentIdentifier")
      end
      it "should have identifierType" do
         test_attribute_xpath(@datastream, 'identifierType', "//oxns:agentIdentifier/oxns:agentIdentifierType")
      end
      it "should have identifierValue" do
         test_attribute_xpath(@datastream, 'identifierValue', "//oxns:agentIdentifier/oxns:agentIdentifierValue")
      end

      it "should have agentName" do
         test_attribute_xpath(@datastream, 'agentName', "//oxns:agentName")
      end
      it "should have agentNote" do
         test_attribute_xpath(@datastream, 'agentNote', "//oxns:agentNote")
      end
      it "should have agentExtension" do
         test_attribute_xpath(@datastream, 'agentExtension', "//oxns:agentExtension")
      end
      it "should have agentType" do
         test_attribute_xpath(@datastream, 'agentType', "//oxns:agentType")
      end

      it "should have linkingEventIdentifier" do
         test_attribute_xpath(@datastream, 'linkingEventIdentifier', "//oxns:linkingEventIdentifier")
      end
      it "should have linkingEventIdentifierType" do
         test_attribute_xpath(@datastream, 'linkingEventIdentifierType', "//oxns:linkingEventIdentifier/oxns:linkingEventIdentifierType")
      end
      it "should have linkingEventIdentifierValue" do
         test_attribute_xpath(@datastream, 'linkingEventIdentifierValue', "//oxns:linkingEventIdentifier/oxns:linkingEventIdentifierValue")
      end

      it "should have linkingRightsStatementIdentifier" do
         test_attribute_xpath(@datastream, 'linkingRightsStatementIdentifier', "//oxns:linkingRightsStatementIdentifier")
      end
      it "should have linkingRightsStatementIdentifierType" do
         test_attribute_xpath(@datastream, 'linkingRightsStatementIdentifierType', "//oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierType")
      end
      it "should have linkingRightsStatementIdentifierValue" do
         test_attribute_xpath(@datastream, 'linkingRightsStatementIdentifierValue', "//oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierValue")
      end

   end

   describe "with existing datastream" do
     before do
       file = File.new(File.join(File.dirname(__FILE__),'..','..','fixtures', "agent_ds_sample.xml"))
       @datastream = MedusaPremis::Datastream::AgentDs.from_xml(file)
     end

     it "should have first occurence of identifierType" do
        test_existing_attribute_nth_occurence(@datastream, 1, 'identifierType', "LOCAL")
     end
     it "should have multiple identifierType" do
        test_existing_attribute_multiple_occurence(@datastream, 'identifierType', ['LOCAL', 'UIUC NETID', 'EMAIL', 'SOFTWARE_VERSION'])
     end
     it "should have multiple identifierValue" do
        test_existing_attribute_multiple_occurence(@datastream, 'identifierValue', ['MEDUSA:1581d4a9-c6a0-4b69-b2d1-969f4a36208a-1', 'UIUC\name_here', 'First_name Last_name', 'FolderPackager 1.0.0.0'])
     end

     it "should have agentType" do
         test_existing_attribute(@datastream, 'agentType', 'SOFTWARE')
     end
     it "should have agentName" do
         test_existing_attribute(@datastream, 'agentName', 'FolderPackager 1.0.0.0 [Library, University of Illinois at Urbana-Champaign]')
     end
     it "should have first occurence of agentNote" do
        test_existing_attribute_nth_occurence(@datastream, 1, 'agentNote', "Run on Computer: LIBGRLUGH, Microsoft Windows 7 Ultimate V6.1.7601.65536, English (United States)")
     end

     it "should have linkingEventIdentifierType" do
         test_existing_attribute(@datastream, 'linkingEventIdentifierType', 'LC Event ID')
     end
     it "should have linkingEventIdentifierValue" do
         test_existing_attribute(@datastream, 'linkingEventIdentifierValue', 'eID-58f202ac-22cf-11')
     end
     it "should have linkingRightsStatementIdentifierType" do
         test_existing_attribute(@datastream, 'linkingRightsStatementIdentifierType', 'LC Rights ID')
     end
     it "should have linkingRightsStatementIdentifierValue" do
         test_existing_attribute(@datastream, 'linkingRightsStatementIdentifierValue', 'rID-58f202ac-22cf-11')
     end

     describe "insert identifier node into existing premis agent" do
       it "should work when BOTH values of identifierType & identifierValue are provided" do
         @datastream.insert_identifier(:identifierType=>"5_TEST", :identifierValue=>"5_test_value_here")
         test_existing_attribute_nth_occurence(@datastream, 5, 'identifierType', "5_TEST")
         test_existing_attribute_nth_occurence(@datastream, 5, 'identifierValue', "5_test_value_here")
       end
       it "should work when ONLY value of identifierType is provided" do
         @datastream.insert_identifier(:identifierType=>"6_TEST")
         test_existing_attribute_nth_occurence(@datastream, 5, 'identifierType', "6_TEST")
         test_existing_attribute_nth_occurence(@datastream, 5, 'identifierValue', "")
       end
       it "should work when ONLY value of identifierValue is provided" do
         @datastream.insert_identifier(:identifierValue=>"7_test_value_here")
         test_existing_attribute_nth_occurence(@datastream, 5, 'identifierType', "")
         test_existing_attribute_nth_occurence(@datastream, 5, 'identifierValue', "7_test_value_here")
       end
       it "should work when NEITHER values of identifierType & identifierValue are provided" do
         @datastream.insert_identifier
         test_existing_attribute_nth_occurence(@datastream, 5, 'identifierType', "")
         test_existing_attribute_nth_occurence(@datastream, 5, 'identifierValue', "")
       end
     end 
   end
end

