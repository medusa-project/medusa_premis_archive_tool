module MedusaPremis
  module Datastream
    class AgentDs < ActiveFedora::OmDatastream
      set_terminology do |t|
        t.root(:path=>'agent', :xmlns=>'info:lc/xmlns/premis-v2', :schema=>"http://www.loc.gov/standards/premis/v2/premis-v2-1.xsd")
 
        # repeatable
        t.identifier(:path=>"agentIdentifier")
          t.identifierType(:path=>"agentIdentifier/oxns:agentIdentifierType", :index_as=>[:stored_searchable])
          t.identifierValue(:path=>"agentIdentifier/oxns:agentIdentifierValue", :index_as=>[:stored_searchable])
    
        # repeatable
        t.agentName(:path=>"agentName", :index_as=>[:stored_searchable])
        t.agentNote(:path=>"agentNote", :index_as=>[:stored_searchable])
        t.agentExtension(:path=>"agentExtension", :index_as=>[:stored_searchable])

        # non-repeatable
        t.agentType(:path=>"agentType", :index_as=>[:stored_searchable])

        # No need to store Premis Relationship elements.  RELS-EXT has these relationships
        # repeatable
        t.linkingEventIdentifier(:path=>"linkingEventIdentifier")
          t.linkingEventIdentifierType(:path=>"linkingEventIdentifier/oxns:linkingEventIdentifierType")
          t.linkingEventIdentifierValue(:path=>"linkingEventIdentifier/oxns:linkingEventIdentifierValue")
    
        # repeatable
        t.linkingRightsStatementIdentifier(:path=>"linkingRightsStatementIdentifier")
          t.linkingRightsStatementIdentifierType(:path=>"linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierType")
          t.linkingRightsStatementIdentifierValue(:path=>"linkingRightsStatementIdentifier/oxns:linkingRightsStatementIdentifierValue")
    
      end

      def self.xml_template
        Nokogiri::XML::Document.parse(File.new(File.join(File.dirname(__FILE__),'..', '..', '..', '..', 'lib/medusa_premis_init_ds/default_datastream', "premis_agent.xml")))
      end

      def self.identifier_template(type, value)
        builder = Nokogiri::XML::Builder.new do |xml|
          xml.agentIdentifier do
            xml.agentIdentifierType_ type
            xml.agentIdentifierValue_ value
          end
        end
        return builder.doc.root
      end

      # Inserts a new identifier node into the premis agent.
      #   USE: if a is MedusaPremis::Agent, 
      #      a.datastreams['Premis-Agent'].insert_identifier(:identifierType=>"type_here", :identifierValue=>"value_here")
      #      a.datastreams['Premis-Agent'].save    OR a.save to save premis agent, rather than just datastream
      def insert_identifier(opts={})
        type = nil
        if !opts[:identifierType].nil?
           type = opts[:identifierType]
        end
        value = nil
        if !opts[:identifierValue].nil?
           value = opts[:identifierValue]
        end
        node = MedusaPremis::Datastream::AgentDs.identifier_template(type, value)
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
