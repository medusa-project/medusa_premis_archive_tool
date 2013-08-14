module MedusaPremis

  class MatchFileObjectValidator < ActiveModel::Validator
    def validate(record)
      # Make sure type/value pairs
      if (record.identifierType.length != record.identifierValue.length)
        record.errors[:identifierType] << "Identifier (file) type/value number mismatch"
      end
      if (record.linkingEventIdentifierType.length != record.linkingEventIdentifierValue.length)
        record.errors[:linkingEventIdentifierType] << "Linking Event Identifier type/value number mismatch"
      end
      if (record.linkingIntellectualEntityIdentifierType.length != record.linkingIntellectualEntityIdentifierValue.length)
        record.errors[:linkingIntellectualEntityIdentifierType] << "Linking Intellectual Entity Identifier type/value number mismatch"
      end
      if (record.linkingRightsStatementIdentifierType.length != record.linkingRightsStatementIdentifierValue.length)
        record.errors[:linkingRightsStatementIdentifierType] << "Linking Rights Statement Identifier type/value number mismatch"
      end
      if (record.objectRelatedObjectIdentifierType.length != record.objectRelatedObjectIdentifierValue.length)
        record.errors[:objectRelatedObjectIdentifierType] << "Related Object Identifier (relationship) type/value number mismatch"
      end
    end
  end

  class FileObject < MedusaPremis::General

    # store in Fedora everytime you create an object, even if unchanged (the non-empty, default template)
    before_create :mark_dirty
    def mark_dirty
       self.datastreams['Premis-File-Object'].ng_xml_will_change!
    end

    belongs_to :representationObject, :class_name=>"MedusaPremis::RepresentationObject", :property => :linking_folder_object
    has_and_belongs_to_many :events, :class_name => "MedusaPremis::Event", :property=>:linking_event, :inverse_of=>:linking_event
    has_and_belongs_to_many :rightsStatements, :class_name => "MedusaPremis::RightsStatement", :property=>:linking_rights_statement, :inverse_of=>:linking_rights_statement
    has_metadata :name => 'Premis-File-Object', :type => MedusaPremis::Datastream::FileObjectDs
    has_file_datastream :name => 'content', :type => MedusaPremis::Datastream::FileContentDs

    # has_metadata :name => 'Premis-File-Object-Internal', :type => ActiveFedora::SimpleDatastream do |c|
    #   c.field :file_object_creator_in_fedora, :string
    # end
    # delegate_to :Premis-File-Object-Internal, [:file_object_creator_in_fedora]

    delegate_to 'Premis-File-Object', [:identifierType, :identifierValue,
                                       :objectCharacteristics_CompositionLevel, :objectCharacteristics_fixitymessageDigestAlgorithm, :objectCharacteristics_fixitymessageDigest, :objectCharacteristics_fixitymessageDigestOriginator, :objectCharacteristics_size, :objectCharacteristics_formatName, :objectCharacteristics_formatVersion, :objectCharacteristics_formatRegistryName, :objectCharacteristics_formatRegistryKey, :objectCharacteristics_formatRegistryRole, :objectCharacteristics_creatingApplicationName, :objectCharacteristics_creatingApplicationVersion, :objectCharacteristics_dateCreatedByApplication,
                                       :objectPreservationLevelValue, :objectPreservationLevelRationale, :objectPreservationLevelDateAssigned,
                                       :objectOriginalName,
                                       :linkingEventIdentifierType, :linkingEventIdentifierValue,
                                       :linkingIntellectualEntityIdentifierType, :linkingIntellectualEntityIdentifierValue,  
                                       :linkingRightsStatementIdentifierType, :linkingRightsStatementIdentifierValue,
                                       :objectRelationshipType, :objectRelationshipSubType, :objectRelatedObjectIdentifierType, :objectRelatedObjectIdentifierValue]

    validates :identifierType, :presence=>true
    validates :identifierValue, :presence=>true
    validates :objectCharacteristics_CompositionLevel, :presence=>true
    validates_with MatchFileObjectValidator

    def to_solr(solr_doc = {}, opts={})
      super(solr_doc, opts)

      facetable = Solrizer::Descriptor.new(:string, :indexed, :multivalued)
      singleString = Solrizer::Descriptor.new(:string, :indexed, :stored)
      storedInt = Solrizer::Descriptor.new(:integer, :indexed, :stored)
      storedIntMulti = Solrizer::Descriptor.new(:integer, :indexed, :stored, :multivalued)

      Solrizer.insert_field(solr_doc, "premis_model_facet", 'File Object', facetable )

      return solr_doc
    end
  end
end
