require 'spec_helper'

describe MedusaPremis::Datastream::RightsStatementDs do
   describe "with new datastream" do
      before do
         @datastream = MedusaPremis::Datastream::RightsStatementDs.new(nil,'Premis-Rights-Statement')
      end
      it "should have identifier" do
         test_attribute_xpath(@datastream, 'identifier', "//oxns:rightsStatement/oxns:rightsStatementIdentifier")
      end
      it "should have identifierType" do
         test_attribute_xpath(@datastream, 'identifierType', "//oxns:rightsStatement/oxns:rightsStatementIdentifier/oxns:rightsStatementIdentifierType")
      end
      it "should have identifierValue" do
         test_attribute_xpath(@datastream, 'identifierValue', "//oxns:rightsStatement/oxns:rightsStatementIdentifier/oxns:rightsStatementIdentifierValue")
      end

      it "should have rightsStatementBasis" do
         test_attribute_xpath(@datastream, 'rightsStatementBasis', "//oxns:rightsStatement/oxns:rightsBasis")
      end

      it "should have rightsStatementCopyrightInformation" do
         test_attribute_xpath(@datastream, 'rightsStatementCopyrightInformation', "//oxns:rightsStatement/oxns:copyrightInformation")
      end
      it "should have rightsStatementCopyrightStatus" do
         test_attribute_xpath(@datastream, 'rightsStatementCopyrightStatus', "//oxns:rightsStatement/oxns:copyrightInformation/oxns:copyrightStatus")
      end
      it "should have rightsStatementCopyrightJurisdiction" do
         test_attribute_xpath(@datastream, 'rightsStatementCopyrightJurisdiction', "//oxns:rightsStatement/oxns:copyrightInformation/oxns:copyrightJurisdiction")
      end

      it "should have rightsStatementGranted" do
         test_attribute_xpath(@datastream, 'rightsStatementGranted', "//oxns:rightsStatement/oxns:rightsGranted")
      end
      it "should have rightsStatementLinkingObjectIdentifierType_GrantedAct" do
         test_attribute_xpath(@datastream, 'rightsStatementLinkingObjectIdentifierType_GrantedAct', "//oxns:rightsStatement/oxns:rightsGranted/oxns:act")
      end
      it "should have rightsStatementGrantedRestriction" do
         test_attribute_xpath(@datastream, 'rightsStatementGrantedRestriction', "//oxns:rightsStatement/oxns:rightsGranted/oxns:restriction")
      end

      it "should have linkingObjectIdentifier" do
         test_attribute_xpath(@datastream, 'linkingObjectIdentifier', "//oxns:rightsStatement/oxns:linkingObjectIdentifier")
      end
      it "should have linkingObjectIdentifierType" do
         test_attribute_xpath(@datastream, 'linkingObjectIdentifierType', "//oxns:rightsStatement/oxns:linkingObjectIdentifier/oxns:linkingObjectIdentifierType")
      end
      it "should have linkingObjectIdentifierValue" do
         test_attribute_xpath(@datastream, 'linkingObjectIdentifierValue', "//oxns:rightsStatement/oxns:linkingObjectIdentifier/oxns:linkingObjectIdentifierValue")
      end
      it "should have linkingObjectRole" do
         test_attribute_xpath(@datastream, 'linkingObjectRole', "//oxns:rightsStatement/oxns:linkingObjectIdentifier/oxns:linkingObjectRole")
      end

      it "should have linkingAgentIdentifier" do
         test_attribute_xpath(@datastream, 'linkingAgentIdentifier', "//oxns:rightsStatement/oxns:linkingAgentIdentifier")
      end
      it "should have linkingAgentIdentifierType" do
         test_attribute_xpath(@datastream, 'linkingAgentIdentifierType', "//oxns:rightsStatement/oxns:linkingAgentIdentifier/oxns:linkingAgentIdentifierType")
      end
      it "should have linkingAgentIdentifierValue" do
         test_attribute_xpath(@datastream, 'linkingAgentIdentifierValue', "//oxns:rightsStatement/oxns:linkingAgentIdentifier/oxns:linkingAgentIdentifierValue")
      end
      it "should have linkingAgentRole" do
         test_attribute_xpath(@datastream, 'linkingAgentRole', "//oxns:rightsStatement/oxns:linkingAgentIdentifier/oxns:linkingAgentRole")
      end
   end

   describe "with existing datastream" do
     before do
       file = File.new(File.join(File.dirname(__FILE__),'..','..','fixtures', "rights_statement_ds_sample.xml"))
       @datastream = MedusaPremis::Datastream::RightsStatementDs.from_xml(file)
     end

     it "should have first occurence of identifierType" do
        test_existing_attribute_nth_occurence(@datastream, 1, 'identifierType', "LOCAL")
     end
     it "should have first occurence of identifierValue" do
        test_existing_attribute_nth_occurence(@datastream, 1, 'identifierValue', "local_identifier_for_rights_one")
     end

     it "should have rightsStatementBasis" do
        test_existing_attribute(@datastream, 'rightsStatementBasis', 'COPYRIGHT')
     end
     it "should have rightsStatementCopyrightStatus" do
        test_existing_attribute(@datastream, 'rightsStatementCopyrightStatus', 'IN_COPYRIGHT')
     end
     it "should have rightsStatementCopyrightJurisdiction" do
        test_existing_attribute(@datastream, 'rightsStatementCopyrightJurisdiction', 'United States')
     end
     it "should have rightsStatementLinkingObjectIdentifierType_GrantedAct" do
        test_existing_attribute(@datastream, 'rightsStatementLinkingObjectIdentifierType_GrantedAct', 'DISSEMINATE')
     end
     it "should have rightsStatementGrantedRestriction" do
        test_existing_attribute(@datastream, 'rightsStatementGrantedRestriction', 'CAMPUS_ONLY')
     end

     it "should have linkingObjectIdentifierType" do
        test_existing_attribute(@datastream, 'linkingObjectIdentifierType', 'LOCAL')
     end
     it "should have linkingObjectIdentifierValue" do
        test_existing_attribute(@datastream, 'linkingObjectIdentifierValue', 'local_linked_object_one')
     end
     it "should have linkingObjectRole" do
        test_existing_attribute(@datastream, 'linkingObjectRole', '')
     end

     describe "insert identifier node into existing premis right" do
       it "should work when BOTH values of statementIdentifierType & statementIdentifierValue are provided" do
         @datastream.insert_identifier(:identifierType=>"5_TEST", :identifierValue=>"5_test_value_here")
         test_existing_attribute_nth_occurence(@datastream, 2, 'identifierType', "5_TEST")
         test_existing_attribute_nth_occurence(@datastream, 2, 'identifierValue', "5_test_value_here")
       end
       it "should work when ONLY value of identifierType is provided" do
         @datastream.insert_identifier(:identifierType=>"6_TEST")
         test_existing_attribute_nth_occurence(@datastream, 2, 'identifierType', "6_TEST")
         test_existing_attribute_nth_occurence(@datastream, 2, 'identifierValue', "")
       end
       it "should work when ONLY value of identifierValue is provided" do
         @datastream.insert_identifier(:identifierValue=>"7_test_value_here")
         test_existing_attribute_nth_occurence(@datastream, 2, 'identifierType', "")
         test_existing_attribute_nth_occurence(@datastream, 2, 'identifierValue', "7_test_value_here")
       end
       it "should work when NEITHER values of identifierType & identifierValue are provided" do
         @datastream.insert_identifier
         test_existing_attribute_nth_occurence(@datastream, 2, 'identifierType', "")
         test_existing_attribute_nth_occurence(@datastream, 2, 'identifierValue', "")
       end
     end 
   end
end

