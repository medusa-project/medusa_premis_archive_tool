module MedusaPremis
  module Datastream
    class RightsStatementDs < ActiveFedora::OmDatastream
      set_terminology do |t|
        t.root(:path=>'rights', :xmlns=>'info:lc/xmlns/premis-v2', :schema=>"http://www.loc.gov/standards/premis/v2/premis-v2-1.xsd")
 
        t.right_Statement(:path=>"rightsStatement")
          # non-repeatable, mandatory
          t.identifier(:path=>"rightsStatement/oxns:rightsStatementIdentifier")
            t.identifierType(:path=>"rightsStatement/oxns:rightsStatementIdentifier/oxns:rightsStatementIdentifierType", :index_as=>[:stored_searchable])
            t.identifierValue(:path=>"rightsStatement/oxns:rightsStatementIdentifier/oxns:rightsStatementIdentifierValue", :index_as=>[:stored_searchable])
          t.rightsStatementBasis(:path=>"rightsStatement/oxns:rightsBasis", :index_as=>[:stored_searchable])

          # non-repeatable, optional (group)
          t.rightsStatementCopyrightInformation(:path=>"rightsStatement/oxns:copyrightInformation")
            t.rightsStatementCopyrightStatus(:path=>"rightsStatement/oxns:copyrightInformation/oxns:copyrightStatus", :index_as=>[:stored_searchable])
            t.rightsStatementCopyrightJurisdiction(:path=>"rightsStatement/oxns:copyrightInformation/oxns:copyrightJurisdiction", :index_as=>[:stored_searchable])

          # repeatable, optional (group)
          t.rightsStatementGranted(:path=>"rightsStatement/oxns:rightsGranted")
            t.rightsStatementLinkingObjectIdentifierType_GrantedAct(:path=>"rightsStatement/oxns:rightsGranted/oxns:act", :index_as=>[:stored_searchable])
            t.rightsStatementGrantedRestriction(:path=>"rightsStatement/oxns:rightsGranted/oxns:restriction", :index_as=>[:stored_searchable])

          # No need to store Premis Relationship elements.  RELS-EXT has these relationships
          # repeatable, optional group
          t.linkingObjectIdentifier(:path=>"rightsStatement/oxns:linkingObjectIdentifier")
            t.linkingObjectIdentifierType(:path=>"rightsStatement/oxns:linkingObjectIdentifier/oxns:linkingObjectIdentifierType")
            t.linkingObjectIdentifierValue(:path=>"rightsStatement/oxns:linkingObjectIdentifier/oxns:linkingObjectIdentifierValue")
            t.linkingObjectRole(:path=>"rightsStatement/oxns:linkingObjectIdentifier/oxns:linkingObjectRole")

          # repeatable, optional group
          t.linkingAgentIdentifier(:path=>"rightsStatement/oxns:linkingAgentIdentifier")
            t.linkingAgentIdentifierType(:path=>"rightsStatement/oxns:linkingAgentIdentifier/oxns:linkingAgentIdentifierType")
            t.linkingAgentIdentifierValue(:path=>"rightsStatement/oxns:linkingAgentIdentifier/oxns:linkingAgentIdentifierValue")
            t.linkingAgentRole(:path=>"rightsStatement/oxns:linkingAgentIdentifier/oxns:linkingAgentRole")
      end

      def self.xml_template
        Nokogiri::XML::Document.parse(File.new(File.join(File.dirname(__FILE__),'..', '..', '..', '..', 'lib/medusa_premis_init_ds/default_datastream', "premis_right.xml")))
      end

      def self.identifier_template(type, value)
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.rightsStatementIdentifier do
            xml.rightsStatementIdentifierType_ type
            xml.rightsStatementIdentifierValue_ value
          end
        end
        return builder.doc.root
      end

      # Inserts a new right_StatementIdentifier node into the premis right.
      #    USE: if a is MedusaPremis::RightsStatement,
      #      a.datastreams['Premis-Rights-Statment'].insert_identifier(:identifierType=>"type_here", :identifierValue=>"value_here")
      #      a.datastreams['Premis-Rights-Statement'].save    OR a.save to save premis object, rather than just datastream
      def insert_identifier(opts={})
        type = nil
        if !opts[:identifierType].nil?
           type = opts[:identifierType]
        end
        value = nil
        if !opts[:identifierValue].nil?
           value = opts[:identifierValue]
        end
        node = MedusaPremis::Datastream::RightsStatementDs.identifier_template(type, value)
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
