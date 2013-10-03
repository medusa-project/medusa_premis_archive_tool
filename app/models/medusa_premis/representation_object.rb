module MedusaPremis

  class MatchRepresentationObjectValidator < ActiveModel::Validator
    def validate(record)
      # Make sure type/value pairs
      if (record.identifierType.length != record.identifierValue.length)
        record.errors[:identifierType] << "Identifier (Representation) type/value number mismatch"
      end
      # No need to store Premis Relationship elements.  RELS-EXT has these relationships
      # if (record.linkingEventIdentifierType.length != record.linkingEventIdentifierValue.length)
      #   record.errors[:linkingEventIdentifierType] << "Linking Event Identifier type/value number mismatch"
      # end

      # if (record.linkingIntellectualEntityIdentifierType.length != record.linkingIntellectualEntityIdentifierValue.length)
      #   record.errors[:linkingIntellectualEntityIdentifierType] << "Linking Intellectual Entity Identifier type/value number mismatch"
      # end

      # if (record.linkingRightsStatementIdentifierType.length != record.linkingRightsStatementIdentifierValue.length)
      #   record.errors[:linkingRightsStatementIdentifierType] << "Linking Rights Statement Identifier type/value number mismatch"
      # end

      # if (record.objectRelatedObjectIdentifierType.length != record.objectRelatedObjectIdentifierValue.length)
      #   record.errors[:objectRelatedObjectIdentifierType] << "Related Object Identifier (relationship) type/value number mismatch"
      # end
    end
  end

  class RepresentationObject < MedusaPremis::General

    # store in Fedora everytime you create an object, even if unchanged (the non-empty, default template)
    before_create :mark_dirty
    def mark_dirty
       self.datastreams['Premis-Representation-Object'].ng_xml_will_change!
    end

    belongs_to :representationObject, :class_name=>"MedusaPremis::RepresentationObject", :property => :linking_folder_object
    has_many :fileObjects, :class_name=>"MedusaPremis::FileObject", :property => :linking_object
    has_and_belongs_to_many :events, :class_name => "MedusaPremis::Event", :property=>:linking_event, :inverse_of=>:linking_event
    has_and_belongs_to_many :rightsStatement, :class_name => "MedusaPremis::RightsStatement", :property=>:linkingi_rights_statement, :inverse_of=>:linking_rights_statement 
    has_metadata :name => 'Premis-Representation-Object', :type => MedusaPremis::Datastream::RepresentationObjectDs

    # has_metadata :name => 'Premis-Representation-Object-Internal', :type => ActiveFedora::SimpleDatastream do |c|
    #   c.field :representationObjectCreator, :string
    # end
    # delegate_to :Premis-Representation-Object-Internal, [:representationObjectCreator]

    delegate_to 'Premis-Representation-Object', [:identifierType, :identifierValue,
                                                 :objectPreservationLevelValue, :objectPreservationLevelRationale, :objectPreservationLevelDateAssigned,
                                                 :objectOriginalName]
    # No need to store Premis Relationship elements.  RELS-EXT has these relationships
    #                                              :linkingEventIdentifierType, :linkingEventIdentifierValue,
    #                                              :linkingIntellectualEntityIdentifierType, :linkingIntellectualEntityIdentifierValue,  
    #                                              :linkingRightsStatementIdentifierType, :linkingRightsStatementIdentifierValue,
    #                                              :objectRelationshipType, :objectRelationshipSubType, :objectRelatedObjectIdentifierType, :objectRelatedObjectIdentifierValue]

    validates :identifierType, :presence=>true
    validates :identifierValue, :presence=>true
    validates_with MatchRepresentationObjectValidator

    def to_solr(solr_doc = {}, opts={})
      super(solr_doc, opts)

      facetable = Solrizer::Descriptor.new(:string, :indexed, :multivalued)
      singleString = Solrizer::Descriptor.new(:string, :indexed, :stored)
      storedInt = Solrizer::Descriptor.new(:integer, :indexed, :stored)
      storedIntMulti = Solrizer::Descriptor.new(:integer, :indexed, :stored, :multivalued)

      Solrizer.insert_field(solr_doc, "premis_model_facet", 'Representation Object', facetable )

      return solr_doc
    end
  end
end
