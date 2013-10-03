require 'spec_helper'

describe MedusaPremis::Datastream::EventDs do
   describe "with new datastream" do
      before do
         @datastream = MedusaPremis::Datastream::EventDs.new(nil,'Premis-Event')
      end
      it "should have identifier" do
         test_attribute_xpath(@datastream, 'identifier', "//oxns:eventIdentifier")
      end
      it "should have identifierType" do
         test_attribute_xpath(@datastream, 'identifierType', "//oxns:eventIdentifier/oxns:eventIdentifierType")
      end
      it "should have identifierValue" do
         test_attribute_xpath(@datastream, 'identifierValue', "//oxns:eventIdentifier/oxns:eventIdentifierValue")
      end

      it "should have eventType" do
         test_attribute_xpath(@datastream, 'eventType', "//oxns:eventType")
      end
      it "should have eventDateTime" do
         test_attribute_xpath(@datastream, 'eventDateTime', "//oxns:eventDateTime")
      end
      it "should have eventDetail" do
         test_attribute_xpath(@datastream, 'eventDetail', "//oxns:eventDetail")
      end

      it "should have linkingAgentIdentifier" do
         test_attribute_xpath(@datastream, 'linkingAgentIdentifier', "//oxns:linkingAgentIdentifier")
      end
      it "should have linkingAgentIdentifierType" do
         test_attribute_xpath(@datastream, 'linkingAgentIdentifierType', "//oxns:linkingAgentIdentifier/oxns:linkingAgentIdentifierType")
      end
      it "should have linkingAgentIdentifierValue" do
         test_attribute_xpath(@datastream, 'linkingAgentIdentifierValue', "//oxns:linkingAgentIdentifier/oxns:linkingAgentIdentifierValue")
      end
      it "should have linkingAgentRole" do
         test_attribute_xpath(@datastream, 'linkingAgentRole', "//oxns:linkingAgentIdentifier/oxns:linkingAgentRole")
      end

      it "should have linkingObjectIdentifier" do
         test_attribute_xpath(@datastream, 'linkingObjectIdentifier', "//oxns:linkingObjectIdentifier")
      end
      it "should have linkingObjectIdentifierType" do
         test_attribute_xpath(@datastream, 'linkingObjectIdentifierType', "//oxns:linkingObjectIdentifier/oxns:linkingObjectIdentifierType")
      end
      it "should have linkingObjectIdentifierValue" do
         test_attribute_xpath(@datastream, 'linkingObjectIdentifierValue', "//oxns:linkingObjectIdentifier/oxns:linkingObjectIdentifierValue")
      end
      it "should have linkingObjectRole" do
         test_attribute_xpath(@datastream, 'linkingObjectRole', "//oxns:linkingObjectIdentifier/oxns:linkingObjectRole")
      end

      it "should have eventOutcomeInformation" do
         test_attribute_xpath(@datastream, 'eventOutcomeInformation', "//oxns:eventOutcomeInformation")
      end
      it "should have eventOutcome" do
         test_attribute_xpath(@datastream, 'eventOutcome', "//oxns:eventOutcomeInformation/oxns:eventOutcome")
      end
      it "should have eventOutcomeDetail" do
         test_attribute_xpath(@datastream, 'eventOutcomeDetail', "//oxns:eventOutcomeInformation/oxns:eventOutcomeDetail")
      end
      it "should have eventOutcomeDetailNote" do
         test_attribute_xpath(@datastream, 'eventOutcomeDetailNote', "//oxns:eventOutcomeInformation/oxns:eventOutcomeDetail/oxns:eventOutcomeDetailNote")
      end
      it "should have eventOutcomeDetailExtension" do
         test_attribute_xpath(@datastream, 'eventOutcomeDetailExtension', "//oxns:eventOutcomeInformation/oxns:eventOutcomeDetail/oxns:eventOutcomeDetailExtension")
      end
   end

   describe "with existing datastream" do
     before do
       file = File.new(File.join(File.dirname(__FILE__),'..','..','fixtures', "event_ds_sample.xml"))
       @datastream = MedusaPremis::Datastream::EventDs.from_xml(file)
     end

     it "should have identifierType" do
         test_existing_attribute(@datastream, 'identifierType', 'LOCAL')
     end
     it "should have identifierValue" do
         test_existing_attribute(@datastream, 'identifierValue', '12345')
     end
     it "should have eventType" do
         test_existing_attribute(@datastream, 'eventType', 'validation')
     end
     it "should have eventDateTime" do
         test_existing_attribute(@datastream, 'eventDateTime', '2013-01-01T15:45:00')
     end

     it "should have eventDetail" do
         test_existing_attribute(@datastream, 'eventDetail', 'jhove')
     end

     it "should have multiple linkingAgentIdentifierType" do
        test_existing_attribute_multiple_occurence(@datastream, 'linkingAgentIdentifierType', ['LOCAL', 'MACHINE'])
     end
     it "should have multiple linkingAgentIdentifierValue" do
        test_existing_attribute_multiple_occurence(@datastream, 'linkingAgentIdentifierValue', ['smith', 'smith_machine'])
     end
     it "should have multiple linkingAgentRole" do
        test_existing_attribute_multiple_occurence(@datastream, 'linkingAgentRole', ['primary', 'secondary'])
     end

     it "should have multiple linkingObjectIdentifierType" do
        test_existing_attribute_multiple_occurence(@datastream, 'linkingObjectIdentifierType', ['LOCAL', 'LOCAL', 'LOCAL'])
     end
     it "should have multiple linkingObjectIdentifierValue" do
        test_existing_attribute_multiple_occurence(@datastream, 'linkingObjectIdentifierValue', ['MEDUSA_object_a', 'MEDUSA_object_b', 'MEDUSA_object_c'])
     end
     it "should have multiple linkingObjectRole" do
        test_existing_attribute_multiple_occurence(@datastream, 'linkingObjectRole', ['parent', 'child', 'child'])
     end

     it "should have eventOutcome" do
         test_existing_attribute(@datastream, 'eventOutcome', 'successful')
     end
     it "should have eventOutcomeDetailNote" do
         test_existing_attribute(@datastream, 'eventOutcomeDetailNote', 'well-formed and valid record')
     end
     it "should have eventOutcomeDetailExtension" do
         test_existing_attribute(@datastream, 'eventOutcomeDetailExtension', 'always like this')
     end

     describe "insert eventOutcomeInformation node into existing premis event" do
       it "should work when all sub-tag values of linkingAgentIdentifier are provided" do
         @datastream.insert_eventOutcomeInformation(:eventOutcome=>"good_add", :eventOutcomeDetailNote=>"good_detail_here", :eventOutcomeDetailExtension=>"good_extension_here")
         test_existing_attribute_multiple_occurence(@datastream,  'eventOutcome', ['successful', 'good_add'])
         test_existing_attribute_multiple_occurence(@datastream,  'eventOutcomeDetailNote', ['well-formed and valid record', 'good_detail_here'])
         test_existing_attribute_multiple_occurence(@datastream,  'eventOutcomeDetailExtension', ['always like this', 'good_extension_here'])
       end
     end 
   end
end

