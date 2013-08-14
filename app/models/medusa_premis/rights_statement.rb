module MedusaPremis

  class MatchRightValidator < ActiveModel::Validator
    def validate(record)
      # Make sure type/value pairs
      if (record.identifierType.length != record.identifierValue.length)
        record.errors[:identifierType] << "Rights Statement Identifier type/value number mismatch"
      end

    end
  end

  class RightsStatement < MedusaPremis::General

    # store in Fedora everytime you create an object, even if unchanged (the non-empty, default template)
    before_create :mark_dirty
    def mark_dirty
      self.datastreams['Premis-Rights'].ng_xml_will_change!
    end

    has_and_belongs_to_many :fileObjects, :class_name=>"MedusaPremis::FileObject", :property=>:linking_rights_statement, :inverse_of=>:linking_rights_statement
    # do NOT put explicit relationship in "agents" object
    has_and_belongs_to_many :agents, :class_name=>"MedusaPremis::Agents", :property=>:linking_rights_statement
    has_metadata :name => 'Premis-Rights', :type => MedusaPremis::Datastream::RightsStatementDs

    # has_metadata :name => 'Premis-Rights-Internal', :type => ActiveFedora::SimpleDatastream do |c|
    #   c.field :rightsStatement_creator, :string
    # end
    # delegate_to 'Premis-Rights-Internal', [:rightsStatement_creator]

    delegate_to 'Premis-Rights', [:identifierType, :identifierValue, :rightsStatementBasis, :rightsStatementCopyrightStatus, :rightsStatementCopyrightJurisdiction,
                                 :rightsStatementLinkingObjectIdentifierType_GrantedAct, :rightsStatementGrantedRestriction,
                                 :linkingObjectIdentifierType, :linkingObjectIdentifierValue, :linkingObjectRole,
                                 :linkingAgentIdentifierType, :linkingAgentIdentifierValue, :linkingAgentRole]  

    validates_with MatchRightValidator

    def to_solr(solr_doc = {}, opts={})
      super(solr_doc, opts)

      facetable = Solrizer::Descriptor.new(:string, :indexed, :multivalued)
      singleString = Solrizer::Descriptor.new(:string, :indexed, :stored)
      storedInt = Solrizer::Descriptor.new(:integer, :indexed, :stored)
      storedIntMulti = Solrizer::Descriptor.new(:integer, :indexed, :stored, :multivalued)

      Solrizer.insert_field(solr_doc, "premis_model_facet", 'Rights Statement', facetable )

      return solr_doc
    end
  end
end
