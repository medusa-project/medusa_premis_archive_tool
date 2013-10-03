module MedusaPremis
  module Datastream
    class FileObjectDs < ActiveFedora::OmDatastream
      set_terminology do |t|
        t.root(:path=>'object', :xmlns=>'info:lc/xmlns/premis-v2', "xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance", :schema=>"http://www.loc.gov/standards/premis/v2/premis-v2-1.xsd")

        t.identifier(:path=>"object[@xsi:type='file']/oxns:objectIdentifier")
          t.identifierType(:path=>"object[@xsi:type='file']/oxns:objectIdentifier/oxns:objectIdentifierType", :index_as=>[:stored_searchable])
          t.identifierValue(:path=>"object[@xsi:type='file']/oxns:objectIdentifier/oxns:objectIdentifierValue", :index_as=>[:stored_searchable])

        t.objectCharacteristics_CompositionLevel(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:compositionLevel", :index_as=>[:stored_searchable])
        t.objectCharacteristics_fixitymessageDigestAlgorithm(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:fixity/oxns:messageDigestAlgorithm", :index_as=>[:stored_searchable])
        t.objectCharacteristics_fixitymessageDigest(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:fixity/oxns:messageDigest", :index_as=>[:stored_searchable])
        t.objectCharacteristics_fixitymessageDigestOriginator(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:fixity/oxns:messageDigestOriginator", :index_as=>[:stored_searchable])
        t.objectCharacteristics_size(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:size", :index_as=>[:stored_searchable])
        t.objectCharacteristics_formatName(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatDesignation/oxns:formatName", :index_as=>[:stored_searchable])
        t.objectCharacteristics_formatVersion(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatDesignation/oxns:formatVersion", :index_as=>[:stored_searchable])
        t.objectCharacteristics_formatRegistryName(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatRegistry/oxns:formatRegistryName", :index_as=>[:stored_searchable])
        t.objectCharacteristics_formatRegistryKey(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatRegistry/oxns:formatRegistryKey", :index_as=>[:stored_searchable])
        t.objectCharacteristics_formatRegistryRole(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:format/oxns:formatRegistry/oxns:formatRegistryRole", :index_as=>[:stored_searchable])
        t.objectCharacteristics_creatingApplicationName(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:creatingApplication/oxns:creatingApplicationName", :index_as=>[:stored_searchable])
        t.objectCharacteristics_creatingApplicationVersion(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:creatingApplication/oxns:creatingApplicationVersion", :index_as=>[:stored_searchable])
        t.objectCharacteristics_dateCreatedByApplication(:path=>"object[@xsi:type='file']/oxns:objectCharacteristics/oxns:creatingApplication/oxns:dateCreatedByApplication", :index_as=>[:stored_searchable])

        t.objectPreservationLevelValue(:path=>"object[@xsi:type='file']/oxns:preservationLevel/oxns:preservationLevelValue", :index_as=>[:stored_searchable])
        t.objectPreservationLevelRationale(:path=>"object[@xsi:type='file']/oxns:preservationLevel/oxns:preservationLevelRationale", :index_as=>[:stored_searchable])
        t.objectPreservationLevelDateAssigned(:path=>"object[@xsi:type='file']/oxns:preservationLevel/oxns:preservationLevelDateAssigned", :index_as=>[:stored_searchable])

        t.objectOriginalName(:path=>"object[@xsi:type='file']/oxns:originalName", :index_as=>[:stored_searchable])

        # No need to store Premis Relationship elements.  RELS-EXT has these relationships
        t.linkingEventIdentifierType(:path=>"object[@xsi:type='file']/oxns:linkingEventIdentifier/oxns:linkingEventIdentifierType")
        t.linkingEventIdentifierValue(:path=>"object[@xsi:type='file']/oxns:linkingEventIdentifier/oxns:linkingEventIdentifierValue")

        t.linkingIntellectualEntityIdentifierType(:path=>"object[@xsi:type='file']/oxns:linkingIntellectualEntityIdentifier/oxns:linkingIntellectualEntityIdentifierType")
        t.linkingIntellectualEntityIdentifierValue(:path=>"object[@xsi:type='file']/oxns:linkingIntellectualEntityIdentifier/oxns:linkingIntellectualEntityIdentifierValue")

        t.linkingRightsStatementIdentifierType(:path=>"object[@xsi:type='file']/oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierType")
        t.linkingRightsStatementIdentifierValue(:path=>"object[@xsi:type='file']/oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierValue")

        # Relationships
        t.objectRelationshipType(:path=>"object[@xsi:type='file']/oxns:relationship/oxns:relationshipType")
        t.objectRelationshipSubType(:path=>"object[@xsi:type='file']/oxns:relationship/oxns:relationshipSubType")
        t.objectRelatedObjectIdentifierType(:path=>"object[@xsi:type='file']/oxns:relationship/oxns:relatedObjectIdentification/oxns:relatedObjectIdentifierType")
        t.objectRelatedObjectIdentifierValue(:path=>"object[@xsi:type='file']/oxns:relationship/oxns:relatedObjectIdentification/oxns:relatedObjectIdentifierValue")

        # still need Significant Properties section?

      end

      def self.xml_template
        # Nokogiri::XML.parse("<object/>")
        Nokogiri::XML::Document.parse(File.new(File.join(File.dirname(__FILE__),'..', '..', '..', '..', 'lib/medusa_premis_init_ds/default_datastream', "premis_file_object.xml")))
      end

      def self.identifier_template(type, value)
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.objectIdentifier do
            xml.objectIdentifierType_ type
            xml.objectIdentifierValue_ value
          end
        end
        return builder.doc.root
      end

      # Inserts a new object_file_identifier node into the premis file object.
      #   USE: if a is MedusaPremis:FileObject,  IMPORTANT NOTE: We do not have "File" as separate word in Object's namespace because it causes conflict with Ruby 
      #      a.datastreams['Premis-File-Object'].insert_identifier(:identifierType=>"type_here", :identifierValue=>"value_here")
      #      a.datastreams['Premis-File-Object'].save    OR a.save to save premis object, rather than just datastream
      def insert_identifier(opts={})
        type = nil
        if !opts[:identifierType].nil?
           type = opts[:identifierType]
        end
        value = nil
        if !opts[:identifierValue].nil?
           value = opts[:identifierValue]
        end
        node = MedusaPremis::Datastream::FileObjectDs.identifier_template(type, value)
        nodeset = self.find_by_terms(:identifier)

        unless nodeset.nil?
          if nodeset.empty?
            self.ng_xml.root.add_child(node)
            index = 0
          else
            nodeset.after(node)
            index = nodeset.length
          end
          # deprecated...
          # self.dirty = true
        end
        return node, index
      end
    end
  end
end
