module MedusaPremis

  class MatchEventValidator < ActiveModel::Validator
    def validate(record)
      if (record.identifierType.length != 1)
        record.errors[:identifierType] << "Event Identifier Type must be provided and used only once"
      end
      if (record.identifierValue.length != 1)
        record.errors[:identifierValue] << "Event Identifier Value must be provided and used only once"
      end
      if (record.eventType.length != 1)
        record.errors[:eventType] << "Event Type must be provided and used only once"
      end
      if (record.eventDateTime.length != 1)
        record.errors[:eventDateTime] << "Event Identifier dateTime must be provided and used only once"
      end
      # Make sure type/value pairs
      if (record.identifierType.length != record.identifierValue.length)
        record.errors[:identifierType] << "Event Identifier type/value number mismatch"
      end
      # TODO: validate more      
    end
  end

  class Event < MedusaPremis::General

    # store in Fedora everytime you create an object, even if unchanged (the non-empty, default template)
    before_create :mark_dirty
    def mark_dirty
       self.datastreams['Premis-Event'].ng_xml_will_change!
    end

    has_and_belongs_to_many :representationObjects, :class_name=>"MedusaPremis::RepresentationObject", :property=>:linking_event, :inverse_of=>:linking_event
    has_and_belongs_to_many :fileObjects, :class_name=>"MedusaPremis::FileObject", :property=>:linking_event, :inverse_of=>:linking_event
    # do NOT put explicit relationship in "agents" object 
    has_and_belongs_to_many :agents, :class_name=>"MedusaPremis::Agents", :property=>:linking_event
    has_metadata :name => 'Premis-Event', :type => MedusaPremis::Datastream::EventDs

    # has_metadata :name => 'Event-Internal', :type => ActiveFedora::SimpleDatastream do |c|
    #   c.field :eventCreator, :string
    # end
    # delegate_to :Event-Internal, [:eventCreator]

    delegate_to 'Premis-Event', [:identifierType, :identifierValue, :eventType, :eventDateTime, :eventDetail,
    # No need to store Premis Relationship elements.  RELS-EXT has these relationships
    #                              :linkingAgentIdentifierType, :linkingAgentIdentifierValue, :linkingAgentRole,
    #                              :linkingObjectIdentifierType, :linkingObjectIdentifierValue, :linkingObjectRole,
                                 :eventOutcome, :eventOutcomeDetailNote, :eventOutcomeDetailExtension]

    validates :identifierType, :presence=>true
    validates :identifierValue, :presence=>true
    validates :eventType, :presence=>true
    validates :eventDateTime, :presence=>true
    validates_with MatchEventValidator

    def to_solr(solr_doc = {}, opts={})
      super(solr_doc, opts)

      facetable = Solrizer::Descriptor.new(:string, :indexed, :multivalued)
      singleString = Solrizer::Descriptor.new(:string, :indexed, :stored)
      storedInt = Solrizer::Descriptor.new(:integer, :indexed, :stored)
      storedIntMulti = Solrizer::Descriptor.new(:integer, :indexed, :stored, :multivalued)

      Solrizer.insert_field(solr_doc, "premis_model_facet", 'Event', facetable )

      return solr_doc
    end
  end
end
