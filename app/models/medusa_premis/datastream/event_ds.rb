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

        # No need to store Premis Relationship elements.  RELS-EXT has these relationships
        # repeatable, optional group
        t.linkingAgentIdentifier(:path=>"linkingAgentIdentifier")
          t.linkingAgentIdentifierType(:path=>"linkingAgentIdentifier/oxns:linkingAgentIdentifierType")
          t.linkingAgentIdentifierValue(:path=>"linkingAgentIdentifier/oxns:linkingAgentIdentifierValue")
          t.linkingAgentRole(:path=>"linkingAgentIdentifier/oxns:linkingAgentRole")
    
        # repeatable, optional group
        t.linkingObjectIdentifier(:path=>"linkingObjectIdentifier")
          t.linkingObjectIdentifierType(:path=>"linkingObjectIdentifier/oxns:linkingObjectIdentifierType")
          t.linkingObjectIdentifierValue(:path=>"linkingObjectIdentifier/oxns:linkingObjectIdentifierValue")
          t.linkingObjectRole(:path=>"linkingObjectIdentifier/oxns:linkingObjectRole")
    
        # repeatable, optional
        t.eventOutcomeInformation(:path=>"eventOutcomeInformation")
        t.eventOutcome(:path=>"eventOutcomeInformation/oxns:eventOutcome", :index_as=>[:stored_searchable])
        t.eventOutcomeDetail(:path=>"eventOutcomeInformation/oxns:eventOutcomeDetail")
          t.eventOutcomeDetailNote(:path=>"eventOutcomeInformation/oxns:eventOutcomeDetail/oxns:eventOutcomeDetailNote", :index_as=>[:stored_searchable])
          t.eventOutcomeDetailExtension(:path=>"eventOutcomeInformation/oxns:eventOutcomeDetail/oxns:eventOutcomeDetailExtension", :index_as=>[:stored_searchable])
      end

  def self.xml_template
    # Nokogiri::XML.parse("<event/>")
    Nokogiri::XML::Document.parse(File.new(File.join(File.dirname(__FILE__),'..', '..', '..', '..', 'lib/medusa_premis_init_ds/default_datastream', "premis_event.xml")))
  end

  def self.eventOutcomeInformation_template(outcome, detail_note, detail_extension)
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.eventOutcomeInformation do
        xml.eventOutcome_ outcome
        xml.eventOutcomeDetail do
          xml.eventOutcomeDetailNote_ detail_note
          xml.eventOutcomeDetailExtension_ detail_extension
        end
      end
    end
    return builder.doc.root
  end

  # Inserts a new event_linkingAgentIdentifier node into the premis event.
  #   USE: if e is MedusaPremis::Event,
  #      e.datastreams['Premis-Event'].insert_eventOutcomeInformation(:eventOutcome=>"outcome_here", :eventOutcomeDetailNote=>"detail_note_here", :eventOutcomeDetailExtension=>"detail_extension_here")
  #      e.datastreams['Premis-Event'].save    OR e.save to save premis event, rather than just datastream
  def insert_eventOutcomeInformation(opts={})
    outcome = nil
    if !opts[:eventOutcome].nil?
       outcome = opts[:eventOutcome]
    end
    detail_note = nil
    if !opts[:eventOutcomeDetailNote].nil?
       detail_note = opts[:eventOutcomeDetailNote]
    end
    detail_extension = nil
    if !opts[:eventOutcomeDetailExtension].nil?
       detail_extension = opts[:eventOutcomeDetailExtension]
    end
    node = MedusaPremis::Datastream::EventDs.eventOutcomeInformation_template(outcome, detail_note, detail_extension)
    nodeset = self.find_by_terms(:eventOutcomeInformation)

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

