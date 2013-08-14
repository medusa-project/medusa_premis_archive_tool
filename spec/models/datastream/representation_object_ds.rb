require 'spec_helper'

describe MedusaPremis::Datastream::RepresentationObjectDs do
   describe "with new datastream" do
      before do
         @datastream = ::MedusaPremis::Datastream::RepresentationObjectDs.new(nil,'Premis-Representation-Object')
      end
      it "should have identifier" do
         test_attribute_xpath(@datastream, 'identifier', "//oxns:object[@xsi:type='representation']/oxns:objectIdentifier")
      end
      it "should have identifierType" do
         test_attribute_xpath(@datastream, 'identifierType', "//oxns:object[@xsi:type='representation']/oxns:objectIdentifier/oxns:objectIdentifierType")
      end
      it "should have identifierValue" do
         test_attribute_xpath(@datastream, 'identifierValue', "//oxns:object[@xsi:type='representation']/oxns:objectIdentifier/oxns:objectIdentifierValue")
      end

      it "should have objectOriginalName" do
         test_attribute_xpath(@datastream, 'objectOriginalName', "//oxns:object[@xsi:type='representation']/oxns:originalName")
      end

      it "should have objectPreservationLevelValue" do
         test_attribute_xpath(@datastream, 'objectPreservationLevelValue', "//oxns:object[@xsi:type='representation']/oxns:preservationLevel/oxns:preservationLevelValue")
      end
      it "should have objectPreservationLevelRationale" do
         test_attribute_xpath(@datastream, 'objectPreservationLevelRationale', "//oxns:object[@xsi:type='representation']/oxns:preservationLevel/oxns:preservationLevelRationale")
      end
      it "should have objectPreservationLevelDateAssigned" do
         test_attribute_xpath(@datastream, 'objectPreservationLevelDateAssigned', "//oxns:object[@xsi:type='representation']/oxns:preservationLevel/oxns:preservationLevelDateAssigned")
      end

      it "should have linkingEventIdentifierType" do
         test_attribute_xpath(@datastream, 'linkingEventIdentifierType', "//oxns:object[@xsi:type='representation']/oxns:linkingEventIdentifier/oxns:linkingEventIdentifierType")
      end
      it "should have linkingEventIdentifierValue" do
         test_attribute_xpath(@datastream, 'linkingEventIdentifierValue', "//oxns:object[@xsi:type='representation']/oxns:linkingEventIdentifier/oxns:linkingEventIdentifierValue")
      end

      it "should have linkingIntellectualEntityIdentifierType" do
         test_attribute_xpath(@datastream, 'linkingIntellectualEntityIdentifierType', "//oxns:object[@xsi:type='representation']/oxns:linkingIntellectualEntityIdentifier/oxns:linkingIntellectualEntityIdentifierType")
      end
      it "should have linkingIntellectualEntityIdentifierValue" do
         test_attribute_xpath(@datastream, 'linkingIntellectualEntityIdentifierValue', "//oxns:object[@xsi:type='representation']/oxns:linkingIntellectualEntityIdentifier/oxns:linkingIntellectualEntityIdentifierValue")
      end

      it "should have linkingRightsStatementIdentifierType" do
         test_attribute_xpath(@datastream, 'linkingRightsStatementIdentifierType', "//oxns:object[@xsi:type='representation']/oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierType")
      end
      it "should have linkingRightsStatementIdentifierValue" do
         test_attribute_xpath(@datastream, 'linkingRightsStatementIdentifierValue', "//oxns:object[@xsi:type='representation']/oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierValue")
      end

      it "should have objectRelationshipType" do
         test_attribute_xpath(@datastream, 'objectRelationshipType', "//oxns:object[@xsi:type='representation']/oxns:relationship/oxns:relationshipType")
      end
      it "should have objectRelationshipSubType" do
         test_attribute_xpath(@datastream, 'objectRelationshipSubType', "//oxns:object[@xsi:type='representation']/oxns:relationship/oxns:relationshipSubType")
      end
      it "should have objectRelatedObjectIdentifierType" do
         test_attribute_xpath(@datastream, 'objectRelatedObjectIdentifierType', "//oxns:object[@xsi:type='representation']/oxns:relationship/oxns:relatedObjectIdentification/oxns:relatedObjectIdentifierType")
      end
      it "should have objectRelatedObjectIdentifierValue" do
         test_attribute_xpath(@datastream, 'objectRelatedObjectIdentifierValue', "//oxns:object[@xsi:type='representation']/oxns:relationship/oxns:relatedObjectIdentification/oxns:relatedObjectIdentifierValue")
      end

   end

   describe "with existing datastream" do
     before do
       file = File.new(File.join(File.dirname(__FILE__),'..','..','fixtures', "representation_object_ds_sample.xml"))
       @datastream = MedusaPremis::Datastream::RepresentationObjectDs.from_xml(file)
     end

     it "should have first occurence of identifierType" do
        test_existing_attribute_nth_occurence(@datastream, 1, 'identifierType', "local")
     end
     it "should have multiple identifierType" do
        test_existing_attribute_multiple_occurence(@datastream, 'identifierType', ['local', 'HANDLE'])
     end
     it "should have multiple identifierValue" do
        test_existing_attribute_multiple_occurence(@datastream, 'identifierValue', ['lab', '10111/MEDUSA:xxx'])
     end

     it "should have objectOriginalName" do
         test_existing_attribute(@datastream, 'objectOriginalName', '\\\\machine_name\\original_name')
     end

     it "should have objectPreservationLevelValue" do
         test_existing_attribute(@datastream, 'objectPreservationLevelValue', 'BIT_LEVEL')
     end
     it "should have objectPreservationLevelRationale" do
         test_existing_attribute(@datastream, 'objectPreservationLevelRationale', 'Uncategorized file system capture')
     end
     it "should have objectPreservationLevelDateAssigned" do
         test_existing_attribute(@datastream, 'objectPreservationLevelDateAssigned', '2012-01-01T14:41:03')
     end

     it "should have multiple objectRelationshipType" do
        test_existing_attribute_multiple_occurence(@datastream, 'objectRelationshipType', ['BASIC_COMPOUND_ASSET', 'BASIC_COMPOUND_ASSET'])
     end
     it "should have multiple objectRelationshipSubType" do
        test_existing_attribute_multiple_occurence(@datastream, 'objectRelationshipSubType', ['CHILD', 'CHILD'])
     end
     it "should have multiple objectRelatedObjectIdentifierType" do
        test_existing_attribute_multiple_occurence(@datastream, 'objectRelatedObjectIdentifierType', ['LOCAL', 'LOCAL'])
     end
     it "should have multiple objectRelatedObjectIdentifierValue" do
        test_existing_attribute_multiple_occurence(@datastream, 'objectRelatedObjectIdentifierValue', ['local_identifier_one', 'local_identifier_two'])
     end

     it "should have linkingEventIdentifierType" do
         test_existing_attribute(@datastream, 'linkingEventIdentifierType', 'LOCAL')
     end
     it "should have linkingEventIdentifierValue" do
         test_existing_attribute(@datastream, 'linkingEventIdentifierValue', 'local_linking_event_one')
     end
     it "should have linkingRightsStatementIdentifierType" do
         test_existing_attribute(@datastream, 'linkingRightsStatementIdentifierType', 'LOCAL')
     end
     it "should have linkingRightsStatementIdentifierValue" do
         test_existing_attribute(@datastream, 'linkingRightsStatementIdentifierValue', 'local_rights_statement_one')
     end
     it "should have linkingIntellectualEntityIdentifierType" do
         test_existing_attribute(@datastream, 'linkingIntellectualEntityIdentifierType', 'LOCAL')
     end
     it "should have linkingIntellectualEntityIdentifierValue" do
         test_existing_attribute(@datastream, 'linkingIntellectualEntityIdentifierValue', 'local_intellectual_entity_statement_one')
     end

     describe "insert identifier node into existing premis representation object" do
       it "should work when BOTH values of identifierType & identifierValue are provided" do
         @datastream.insert_identifier(:identifierType=>"3_TEST", :identifierValue=>"3_test_value_here")
         test_existing_attribute_nth_occurence(@datastream, 3, 'identifierType', "3_TEST")
         test_existing_attribute_nth_occurence(@datastream, 3, 'identifierValue', "3_test_value_here")
       end
       it "should work when ONLY value of identifierType is provided" do
         @datastream.insert_identifier(:identifierType=>"4_TEST")
         test_existing_attribute_nth_occurence(@datastream, 3, 'identifierType', "4_TEST")
         test_existing_attribute_nth_occurence(@datastream, 3, 'identifierValue', "")
       end
       it "should work when ONLY value of identifierValue is provided" do
         @datastream.insert_identifier(:identifierValue=>"5_test_value_here")
         test_existing_attribute_nth_occurence(@datastream, 3, 'identifierType', "")
         test_existing_attribute_nth_occurence(@datastream, 3, 'identifierValue', "5_test_value_here")
       end
       it "should work when NEITHER values of identifierType & identifierValue are provided" do
         @datastream.insert_identifier
         test_existing_attribute_nth_occurence(@datastream, 3, 'identifierType', "")
         test_existing_attribute_nth_occurence(@datastream, 3, 'identifierValue', "")
       end
     end 
   end
end

