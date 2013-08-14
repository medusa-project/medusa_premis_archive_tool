module MedusaPremis

  class MatchAgentValidator < ActiveModel::Validator
    def validate(record)
      # Make sure type/value pairs
      if (record.identifierType.length != record.identifierValue.length)
        record.errors[:identifierType] << "Agent Identifier type/value number mismatch"
      end
    end
  end

  class Agent < MedusaPremis::General

    # store in Fedora everytime you create an object, even if unchanged (the non-empty, default template)
    before_create :mark_dirty
    def mark_dirty
       self.datastreams['Premis-Agent'].ng_xml_will_change!
    end

    # do NOT put explicit relationship in "agents" object
    has_and_belongs_to_many :events, :class_name=>"MedusaPremis::Event", :inverse_of=>:linking_event
    has_and_belongs_to_many :rightsStatements, :class_name=>"MedusaPremis::RightsStatement", :inverse_of=>:linking_rights_statement
    has_metadata :name => 'Premis-Agent', :type => MedusaPremis::Datastream::AgentDs

    # has_metadata :name => 'Premis-Agent-Internal', :type => ActiveFedora::SimpleDatastream do |c|
    #   c.field :agentCreator, :string
    # end
    # delegate_to 'Premis-Agent-Internal', [:agentCreator]

    delegate_to 'Premis-Agent', [:identifierType, :identifierValue, :agentName, :agentNote, :agentExtension, :agentType,
                                 :linkingEventIdentifierType, :linkingEventIdentifierValue, 
                                 :linkingRightsStatementIdentifierType, :linkingRightsStatementIdentifierValue]

    validates :identifierType, :presence=>true
    validates :identifierValue, :presence=>true
    validates_with MatchAgentValidator

    def to_solr(solr_doc = {}, opts={})
      super(solr_doc, opts)

      facetable = Solrizer::Descriptor.new(:string, :indexed, :multivalued)
      singleString = Solrizer::Descriptor.new(:string, :indexed, :stored)
      storedInt = Solrizer::Descriptor.new(:integer, :indexed, :stored)
      storedIntMulti = Solrizer::Descriptor.new(:integer, :indexed, :stored, :multivalued)

      Solrizer.insert_field(solr_doc, "premis_model_facet", 'Agent', facetable )
      Solrizer.insert_field(solr_doc, "premis_agent_facet", self.agentName, facetable )

      return solr_doc
    end

  end
end
