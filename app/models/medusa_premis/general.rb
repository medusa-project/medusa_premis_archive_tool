module MedusaPremis
  class General < ActiveFedora::Base
    include Hydra::ModelMethods
    include Hydra::ModelMixins::CommonMetadata
    include Hydra::ModelMixins::RightsMetadata

    def self.return_uri(id)
      # ASSUME: id is an ID, not internal_uri
      # strip off beginning & ending quotes.... ASSUME Id does NOT have beginning or ending quotes
      id.gsub!(/^("|')*/,"").gsub!(/("|')*$/,"")

      begin
        # get uri, if exists 
        x = ActiveFedora::Base.load_instance_from_solr(id)
      rescue ActiveFedora::ObjectNotFoundError
        # print "Problem finding entity with id=#{id}"
        return nil
      rescue
        return nil
      end 

      if (x.nil?) or (x.internal_uri.nil?)
        return nil
      end

      return x.internal_uri
    end 

    def self.get_relations_from_fedora(id, related_id)

      # ASSUME: id and related_id are IDs, not internal_uris

      x,y = String.new
      # strip off beginning & ending quotes.... ASSUME Id does NOT have beginning or ending quotes
      id.gsub!(/^("|')*/,"").gsub!(/("|')*$/,"")

      begin
        # verify id exists
        x = ActiveFedora::Base.load_instance_from_solr(id)
      rescue ActiveFedora::ObjectNotFoundError
        # print "Problem finding entity with id=#{id}"
        return nil
      rescue
        return nil
      end 

      if (x.nil?) or (x.object_relations.nil?)
        return nil
      end

      related_id.gsub!(/^("|')*/,"").gsub!(/("|')*$/,"")
      begin
        # verify related_id exists
        y = ActiveFedora::Base.load_instance_from_solr(related_id)
      rescue ActiveFedora::ObjectNotFoundError
        # print "Problem finding entity with related_id=#{related_id}"
        return nil
      rescue
        return nil
      end 
      
      if (y.nil?) or (y.internal_uri.nil?)
        return nil
      end

      relations = []
      x.object_relations.relationships.keys.each do |z|
        case z
          when :has_model
            # ignore any keys here
          else
            x.object_relations.relationships[z].each do |zz|
              if (zz == y.internal_uri)
                relations << z
              end
            end
        end
      end
      if (relations.empty?)
        # if no relevant rels_ext relationships
        return nil
      end
      return relations.join(", ")
    end  

  end
end
