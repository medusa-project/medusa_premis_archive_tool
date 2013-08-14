module MedusaPremis
  module Datastream
    class EventDs < ActiveFedora::OmDatastream
      set_terminology do |t|
        t.root(:path=>'event', :xmlns=>'info:lc/xmlns/premis-v2', :schema=>"http://www.loc.gov/standards/premis/v2/premis-v2-1.xsd")
 
        # non-repeatable, mandatory
        t.identifier(:path=>"eventIdentifier")
          t.identifierType(:path=>"eventIdentifier/oxns:eventIdentifierType", :index_as=>[:stored_searchable])
          t.identifierValue(:path=>"eventIdentifier/oxns:eventIdentifierValue", :index_as=>[:stored_searchable])
        t.eventType(:path=>"eventType", :index_as=>[:stored_searchable])
        t.eventDateTime(:path=>"eventDateTime", :index_as=>[:stored_searchable])

        # non-repeatable, optional
        t.eventDetail(:path=>"eventDetail", :index_as=>[:stored_searchable])

        # repeatable, optional group
        t.linkingAgentIdentifier(:path=>"linkingAgentIdentifier")
          t.linkingAgentIdentifierType(:path=>"linkingAgentIdentifier/oxns:linkingAgentIdentifierType", :index_as=>[:stored_searchable])
          t.linkingAgentIdentifierValue(:path=>"linkingAgentIdentifier/oxns:linkingAgentIdentifierValue", :index_as=>[:stored_searchable])
          t.linkingAgentRole(:path=>"linkingAgentIdentifier/oxns:linkingAgentRole", :index_as=>[:stored_searchable])
    
        # repeatable, optional group
        t.linkingObjectIdentifier(:path=>"linkingObjectIdentifier")
          t.linkingObjectIdentifierType(:path=>"linkingObjectIdentifier/oxns:linkingObjectIdentifierType", :index_as=>[:stored_searchable])
          t.linkingObjectIdentifierValue(:path=>"linkingObjectIdentifier/oxns:linkingObjectIdentifierValue", :index_as=>[:stored_searchable])
          t.linkingObjectRole(:path=>"linkingObjectIdentifier/oxns:linkingObjectRole", :index_as=>[:stored_searchable])
    
        # repeatable, optional
        t.eventOutcomeInformation(:path=>"eventOutcomeInformation")
        t.eventOutcome(:path=>"eventOutcomeInformation/oxns:eventOutcome", :index_as=>[:stored_searchable])
        t.eventOutcomeDetail(:path=>"eventOutcomeInformation/oxns:eventOutcomeDetail", :index_as=>[:stored_searchable])
          t.eventOutcomeDetailNote(:path=>"eventOutcomeInformation/oxns:eventOutcomeDetail/oxns:eventOutcomeDetailNote", :index_as=>[:stored_searchable])
          t.eventOutcomeDetailExtension(:path=>"eventOutcomeInformation/oxns:eventOutcomeDetail/oxns:eventOutcomeDetailExtension", :index_as=>[:stored_searchable])
      end

  def self.xml_template
    # Nokogiri::XML.parse("<event/>")
    Nokogiri::XML::Document.parse(File.new(File.join(File.dirname(__FILE__),'..', '..', '..', '..', 'lib/medusa_premis_init_ds/default_datastream', "premis_event.xml")))
  end

  def self.linkingAgentIdentifier_template(type, value, role)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.linkingAgentIdentifier do
        xml.linkingAgentIdentifierType_ type
        xml.linkingAgentIdentifierValue_ value
        xml.linkingAgentRole_ role
      end
    end
    return builder.doc.root
  end


  # Inserts a new event_linkingAgentIdentifier node into the premis event.
  #   USE: if e is MedusaPremis::Event,
  #      e.datastreams['Premis-Event'].insert_linkingAgentIdentifier(:linkingAgentIdentifierType=>"type_here", :linkingAgentIdentifierValue=>"value_here", :linkingAgentRole=>"role here")
  #      e.datastreams['Premis-Event'].save    OR e.save to save premis event, rather than just datastream
  def insert_linkingAgentIdentifier(opts={})
    type = nil
    if !opts[:linkingAgentIdentifierType].nil?
       type = opts[:linkingAgentIdentifierType]
    end
    value = nil
    if !opts[:linkingAgentIdentifierValue].nil?
       value = opts[:linkingAgentIdentifierValue]
    end
    role = nil
    if !opts[:linkingAgentRole].nil?
       role = opts[:linkingAgentRole]
    end
    node = MedusaPremis::Datastream::EventDs.linkingAgentIdentifier_template(type, value, role)
    nodeset = self.find_by_terms(:linkingAgentIdentifier)

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

