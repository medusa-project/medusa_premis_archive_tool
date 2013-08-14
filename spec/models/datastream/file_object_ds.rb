require 'spec_helper'

describe MedusaPremis::Datastream::FileObjectDs do
   describe "with new datastream" do
      before do
         @datastream = MedusaPremis::Datastream::FileObjectDs.new(nil,'Premis-File-Object')
      end
      it "should have identifier" do
         test_attribute_xpath(@datastream, 'identifier', "//oxns:object[@xsi:type='file']/oxns:objectIdentifier")
      end
      it "should have identifierType" do
         test_attribute_xpath(@datastream, 'identifierType', "//oxns:object[@xsi:type='file']/oxns:objectIdentifier/oxns:objectIdentifierType")
      end
      it "should have identifierValue" do
         test_attribute_xpath(@datastream, 'identifierValue', "//oxns:object[@xsi:type='file']/oxns:objectIdentifier/oxns:objectIdentifierValue")
      end

      it "should have objectCharacteristics_CompositionLevel" do
         test_attribute_xpath(@datastream, 'objectCharacteristics_CompositionLevel', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:compositionLevel")
      end
      it "should have objectCharacteristics_fixitymessageDigestAlgorithm" do
         test_attribute_xpath(@datastream, 'objectCharacteristics_fixitymessageDigestAlgorithm', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:fixity/oxns:messageDigestAlgorithm")
      end
      it "should have objectCharacteristics_fixitymessageDigest" do
         test_attribute_xpath(@datastream, 'objectCharacteristics_fixitymessageDigest', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:fixity/oxns:messageDigest")
      end
      it "should have objectCharacteristics_fixitymessageDigestOriginator" do
         test_attribute_xpath(@datastream, 'objectCharacteristics_fixitymessageDigestOriginator', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:fixity/oxns:messageDigestOriginator")
      end
      it "should have objectCharacteristics_size" do
         test_attribute_xpath(@datastream, 'objectCharacteristics_size', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:size")
      end
      it "should have objectCharacteristics_formatName" do
         test_attribute_xpath(@datastream, 'objectCharacteristics_formatName', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatDesignation/oxns:formatName")
      end
      it "should have objectCharacteristics_formatVersion" do
         test_attribute_xpath(@datastream, 'objectCharacteristics_formatVersion', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatDesignation/oxns:formatVersion")
      end
      it "should have objectCharacteristics_formatRegistryName" do
         test_attribute_xpath(@datastream, 'objectCharacteristics_formatRegistryName', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatRegistry/oxns:formatRegistryName")
      end
      it "should have objectCharacteristics_formatRegistryKey" do
         test_attribute_xpath(@datastream, 'objectCharacteristics_formatRegistryKey', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatRegistry/oxns:formatRegistryKey")
      end
      it "should have objectCharacteristics_formatRegistryRole" do
         test_attribute_xpath(@datastream, 'objectCharacteristics_formatRegistryRole', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatRegistry/oxns:formatRegistryRole")
      end
      it "should have objectCharacteristics_creatingApplicationName" do
         test_attribute_xpath(@datastream, 'objectCharacteristics_creatingApplicationName', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:creatingApplication/oxns:creatingApplicationName")
      end
      it "should have objectCharacteristics_creatingApplicationVersion" do
         test_attribute_xpath(@datastream, 'objectCharacteristics_creatingApplicationVersion', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:creatingApplication/oxns:creatingApplicationVersion")
      end
      it "should have objectCharacteristics_dateCreatedByApplication" do
         test_attribute_xpath(@datastream, 'objectCharacteristics_dateCreatedByApplication', "//oxns:object[@xsi:type='file']/oxns:objectCharacteristics/oxns:creatingApplication/oxns:dateCreatedByApplication")
      end

      it "should have objectOriginalName" do
         test_attribute_xpath(@datastream, 'objectOriginalName', "//oxns:object[@xsi:type='file']/oxns:originalName")
      end

      it "should have objectPreservationLevelValue" do
         test_attribute_xpath(@datastream, 'objectPreservationLevelValue', "//oxns:object[@xsi:type='file']/oxns:preservationLevel/oxns:preservationLevelValue")
      end
      it "should have objectPreservationLevelRationale" do
         test_attribute_xpath(@datastream, 'objectPreservationLevelRationale', "//oxns:object[@xsi:type='file']/oxns:preservationLevel/oxns:preservationLevelRationale")
      end
      it "should have objectPreservationLevelDateAssigned" do
         test_attribute_xpath(@datastream, 'objectPreservationLevelDateAssigned', "//oxns:object[@xsi:type='file']/oxns:preservationLevel/oxns:preservationLevelDateAssigned")
      end

      it "should have linkingEventIdentifierType" do
         test_attribute_xpath(@datastream, 'linkingEventIdentifierType', "//oxns:object[@xsi:type='file']/oxns:linkingEventIdentifier/oxns:linkingEventIdentifierType")
      end
      it "should have linkingEventIdentifierValue" do
         test_attribute_xpath(@datastream, 'linkingEventIdentifierValue', "//oxns:object[@xsi:type='file']/oxns:linkingEventIdentifier/oxns:linkingEventIdentifierValue")
      end

      it "should have linkingIntellectualEntityIdentifierType" do
         test_attribute_xpath(@datastream, 'linkingIntellectualEntityIdentifierType', "//oxns:object[@xsi:type='file']/oxns:linkingIntellectualEntityIdentifier/oxns:linkingIntellectualEntityIdentifierType")
      end
      it "should have linkingIntellectualEntityIdentifierValue" do
         test_attribute_xpath(@datastream, 'linkingIntellectualEntityIdentifierValue', "//oxns:object[@xsi:type='file']/oxns:linkingIntellectualEntityIdentifier/oxns:linkingIntellectualEntityIdentifierValue")
      end

      it "should have linkingRightsStatementIdentifierType" do
         test_attribute_xpath(@datastream, 'linkingRightsStatementIdentifierType', "//oxns:object[@xsi:type='file']/oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierType")
      end
      it "should have linkingRightsStatementIdentifierValue" do
         test_attribute_xpath(@datastream, 'linkingRightsStatementIdentifierValue', "//oxns:object[@xsi:type='file']/oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierValue")
      end

      it "should have objectRelationshipType" do
         test_attribute_xpath(@datastream, 'objectRelationshipType', "//oxns:object[@xsi:type='file']/oxns:relationship/oxns:relationshipType")
      end
      it "should have objectRelationshipSubType" do
         test_attribute_xpath(@datastream, 'objectRelationshipSubType', "//oxns:object[@xsi:type='file']/oxns:relationship/oxns:relationshipSubType")
      end
      it "should have objectRelatedObjectIdentifierType" do
         test_attribute_xpath(@datastream, 'objectRelatedObjectIdentifierType', "//oxns:object[@xsi:type='file']/oxns:relationship/oxns:relatedObjectIdentification/oxns:relatedObjectIdentifierType")
      end
      it "should have objectRelatedObjectIdentifierValue" do
         test_attribute_xpath(@datastream, 'objectRelatedObjectIdentifierValue', "//oxns:object[@xsi:type='file']/oxns:relationship/oxns:relatedObjectIdentification/oxns:relatedObjectIdentifierValue")
      end

   end

   describe "with existing datastream" do
     before do
       file = File.new(File.join(File.dirname(__FILE__),'..','..','fixtures', "file_object_ds_sample.xml"))
       @datastream = MedusaPremis::Datastream::FileObjectDs.from_xml(file)
     end

     it "should have first occurence of identifierType" do
        test_existing_attribute_nth_occurence(@datastream, 1, 'identifierType', "local")
     end
     it "should have multiple identifierType" do
        test_existing_attribute_multiple_occurence(@datastream, 'identifierType', ['local', 'outside_id'])
     end
     it "should have multiple identifierValue" do
        test_existing_attribute_multiple_occurence(@datastream, 'identifierValue', ["local_identifier_value_here", "outside_id_value_here"])
     end

     it "should have objectOriginalName" do
         test_existing_attribute(@datastream, 'objectOriginalName', '0001h.tif')
     end

     it "should have objectPreservationLevelValue" do
         test_existing_attribute(@datastream, 'objectPreservationLevelValue', 'OBJECT_LEVEL')
     end
     it "should have objectPreservationLevelRationale" do
         test_existing_attribute(@datastream, 'objectPreservationLevelRationale', 'Categorized file system capture')
     end
     it "should have preservationLevelDateAssigned" do
         test_existing_attribute(@datastream, 'objectPreservationLevelDateAssigned', '2013-01-01T14:41:03')
     end

      it "should have objectCharacteristics_CompositionLevel" do
         test_existing_attribute(@datastream, 'objectCharacteristics_CompositionLevel', '0')
      end
      it "should have objectCharacteristics_fixitymessageDigestAlgorithm" do
         test_existing_attribute(@datastream, 'objectCharacteristics_fixitymessageDigestAlgorithm', 'MD5')
      end
      it "should have objectCharacteristics_fixitymessageDigest" do
         test_existing_attribute(@datastream, 'objectCharacteristics_fixitymessageDigest', '36b03197ad066cd719906c55eb68ab8d')
      end
      it "should have objectCharacteristics_fixitymessageDigestOriginator" do
         test_existing_attribute(@datastream, 'objectCharacteristics_fixitymessageDigestOriginator', 'LocalDCMS')
      end
      it "should have objectCharacteristics_size" do
         test_existing_attribute(@datastream, 'objectCharacteristics_size', '20800896')
      end
      it "should have objectCharacteristics_formatName" do
         test_existing_attribute(@datastream, 'objectCharacteristics_formatName', 'image/tiff')
      end
      it "should have objectCharacteristics_formatVersion" do
         test_existing_attribute(@datastream, 'objectCharacteristics_formatVersion', '6.0')
      end
      it "should have objectCharacteristics_formatRegistryName" do
         test_existing_attribute(@datastream, 'objectCharacteristics_formatRegistryName', 'PRONOM')
      end
      it "should have objectCharacteristics_formatRegistryKey" do
         test_existing_attribute(@datastream, 'objectCharacteristics_formatRegistryKey', 'fmt/10')
      end
      it "should have objectCharacteristics_formatRegistryRole" do
         test_existing_attribute(@datastream, 'objectCharacteristics_formatRegistryRole', 'specification')
      end
      it "should have multiple objectCharacteristics_creatingApplicationName" do
         test_existing_attribute_multiple_occurence(@datastream, 'objectCharacteristics_creatingApplicationName', ['ScandAll 21', 'Adobe Photoshop'])
      end
      it "should have multiple objectCharacteristics_creatingApplicationVersion" do
         test_existing_attribute_multiple_occurence(@datastream, 'objectCharacteristics_creatingApplicationVersion', ['4.1.4', 'CS2'])
      end
      it "should have multiple objectCharacteristics_dateCreatedByApplication" do
         test_existing_attribute_multiple_occurence(@datastream, 'objectCharacteristics_dateCreatedByApplication', ['1998-10-30', '2006-09-20T08:29:02'])
      end

     it "should have multiple objectRelationshipType" do
        test_existing_attribute_multiple_occurence(@datastream, 'objectRelationshipType', ['structural', 'structural', 'derivation'])
     end
     it "should have multiple objectRelationshipSubType" do
        test_existing_attribute_multiple_occurence(@datastream, 'objectRelationshipSubType', ['is sibling', 'is sibling', 'is source of'])
     end
     it "should have multiple objectRelatedObjectIdentifierType" do
        test_existing_attribute_multiple_occurence(@datastream, 'objectRelatedObjectIdentifierType', ['hdl', 'URI', 'URL'])
     end
     it "should have multiple objectRelatedObjectIdentifierValue" do
        test_existing_attribute_multiple_occurence(@datastream, 'objectRelatedObjectIdentifierValue', ['loc.music/gottlieb.09602', 'http://lcweb2.loc.gov/cocoon/ihas/loc.natlib.gottlieb.09601/mets.xml', 'http://lcweb2.loc.gov/natlib/ihas/service/gottlieb/09601/ver01/0001v.jpg'])
     end

     it "should have multiple linkingEventIdentifierType" do
         test_existing_attribute_multiple_occurence(@datastream, 'linkingEventIdentifierType', ['Local Repository', 'Local Repository'])
     end
     it "should have multiple linkingEventIdentifierValue" do
         test_existing_attribute_multiple_occurence(@datastream, 'linkingEventIdentifierValue', ['E001.1', 'E001.2'])
     end
     it "should have linkingRightsStatementIdentifierType" do
         test_existing_attribute(@datastream, 'linkingRightsStatementIdentifierType', 'LOCAL')
     end
     it "should have linkingRightsStatementIdentifierValue" do
         test_existing_attribute(@datastream, 'linkingRightsStatementIdentifierValue', 'local_rights_statement_one')
     end
     it "should have multiple linkingIntellectualEntityIdentifierType" do
         test_existing_attribute_multiple_occurence(@datastream, 'linkingIntellectualEntityIdentifierType', ['hdl', 'URI'])
     end
     it "should have multiple linkingIntellectualEntityIdentifierValue" do
         test_existing_attribute_multiple_occurence(@datastream, 'linkingIntellectualEntityIdentifierValue', ['loc.natlib.gottlieb.09601', 'http://lcweb2.loc.gov/cocoon/ihas/loc.natlib.gottlieb.09601/default.html'])
     end

     describe "insert identifier node into existing premis folder object" do
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

