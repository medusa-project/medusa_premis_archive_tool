module MedusaPremis
  module Datastream
    class RepresentationObjectDs < ActiveFedora::OmDatastream
      set_terminology do |t|
        t.root(:path=>'object', :xmlns=>'info:lc/xmlns/premis-v2', "xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance", :schema=>"http://www.loc.gov/standards/premis/v2/premis-v2-1.xsd")

        t.identifier(:path=>"object[@xsi:type='representation']/oxns:objectIdentifier")
          t.identifierType(:path=>"object[@xsi:type='representation']/oxns:objectIdentifier/oxns:objectIdentifierType", :index_as=>[:stored_searchable])
          t.identifierValue(:path=>"object[@xsi:type='representation']/oxns:objectIdentifier/oxns:objectIdentifierValue", :index_as=>[:stored_searchable])

        t.objectOriginalName(:path=>"object[@xsi:type='representation']/oxns:originalName", :index_as=>[:stored_searchable])

        t.objectPreservationLevelValue(:path=>"object[@xsi:type='representation']/oxns:preservationLevel/oxns:preservationLevelValue", :index_as=>[:stored_searchable])
        t.objectPreservationLevelRationale(:path=>"object[@xsi:type='representation']/oxns:preservationLevel/oxns:preservationLevelRationale", :index_as=>[:stored_searchable])
        t.objectPreservationLevelDateAssigned(:path=>"object[@xsi:type='representation']/oxns:preservationLevel/oxns:preservationLevelDateAssigned", :index_as=>[:stored_searchable])

        t.linkingEventIdentifierType(:path=>"object[@xsi:type='representation']/oxns:linkingEventIdentifier/oxns:linkingEventIdentifierType", :index_as=>[:stored_searchable])
        t.linkingEventIdentifierValue(:path=>"object[@xsi:type='representation']/oxns:linkingEventIdentifier/oxns:linkingEventIdentifierValue", :index_as=>[:stored_searchable])

        t.linkingIntellectualEntityIdentifierType(:path=>"object[@xsi:type='representation']/oxns:linkingIntellectualEntityIdentifier/oxns:linkingIntellectualEntityIdentifierType", :index_as=>[:stored_searchable])
        t.linkingIntellectualEntityIdentifierValue(:path=>"object[@xsi:type='representation']/oxns:linkingIntellectualEntityIdentifier/oxns:linkingIntellectualEntityIdentifierValue", :index_as=>[:stored_searchable])

        t.linkingRightsStatementIdentifierType(:path=>"object[@xsi:type='representation']/oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierType", :index_as=>[:stored_searchable])
        t.linkingRightsStatementIdentifierValue(:path=>"object[@xsi:type='representation']/oxns:linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierValue", :index_as=>[:stored_searchable])

        # Relationships
        t.objectRelationshipType(:path=>"object[@xsi:type='representation']/oxns:relationship/oxns:relationshipType", :index_as=>[:stored_searchable])
        t.objectRelationshipSubType(:path=>"object[@xsi:type='representation']/oxns:relationship/oxns:relationshipSubType", :index_as=>[:stored_searchable])
        t.objectRelatedObjectIdentifierType(:path=>"object[@xsi:type='representation']/oxns:relationship/oxns:relatedObjectIdentification/oxns:relatedObjectIdentifierType", :index_as=>[:stored_searchable])
        t.objectRelatedObjectIdentifierValue(:path=>"object[@xsi:type='representation']/oxns:relationship/oxns:relatedObjectIdentification/oxns:relatedObjectIdentifierValue", :index_as=>[:stored_searchable])

        # still need Significant Properties section?

      end

      def self.xml_template
        Nokogiri::XML::Document.parse(File.new(File.join(File.dirname(__FILE__),'..', '..', '..', '..', 'lib/medusa_premis_init_ds/default_datastream', "premis_representation_object.xml")))
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

      # Inserts a new identifier node into the premis folder object.
      #   USE: if a is MedusaPremis::RepresentationObject,
      #      a.datastreams['Premis-Representation-Object'].insert_identifier(:identifierType=>"type_here", :identifierValue=>"value_here")
      #      a.datastreams['Premis-Representation-Object'].save    OR a.save to save premis object, rather than just datastream
      def insert_identifier(opts={})
        type = nil
        if !opts[:identifierType].nil?
           type = opts[:identifierType]
        end
        value = nil
        if !opts[:identifierValue].nil?
          value = opts[:identifierValue]
        end
        node = MedusaPremis::Datastream::RepresentationObjectDs.identifier_template(type, value)
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
