module MedusaPremis
  class General < ActiveFedora::Base
    include Hydra::ModelMethods
    include Hydra::ModelMixins::CommonMetadata
    include Hydra::ModelMixins::RightsMetadata

    ID_THRESHOLD = 200

    def self.ids_or_file(id, type_of_relation)
      # This method takes in an id and a relational query type
      # It returns ids in two forms, depending on a configurable threshold:
      #   1. type: "ids", ids_entity: array of ids
      #   2. type: "file", ids_entity: name of file containing ids
      # In general, number 1 is returned if a few number of ids while 2 is returned for many, many ids
      # Here is the form of a typical call to this method:
      #    results = MedusaPremis::General.ids_or_file(q, type_of_search)
      #      where results is a hash.... results[:type] and results[:ids_entity]

      ids = retrieve_ids_associated_with_id_fedora(id)
      if ids.nil?
        return {:type=>"ids", :ids_entity=>nil}
      end
      if (ids.length < ID_THRESHOLD)
        # return array of ids
        return {:type=>"ids", :ids_entity=>ids}
      else
        # return filename
        # create file....
        
        # for testing
        return {:type=>"file", :ids_entity=>"relate_mana"}
      end
    end


    def self.retrieve_ids_associated_with_id_fedora(id)
      # NOTE: Id here must be an Id, & NOT uri
      begin
        x = ActiveFedora::Base.find(:id => id.to_s).first
      rescue ActiveFedora::ObjectNotFoundError
        # print "Problem finding entity with id=#{id}"
        return nil
      rescue
        return nil
      end 
      # x can be nil here

      if (x.object_relations.nil?)
        return nil
      end

      uris = []
      x.object_relations.relationships.keys.each do |y|
        case y
          when :has_model
            # ignore any keys here
          else
            x.object_relations.relationships[y].each do |z|
              uris << z
            end
        end
      end
 
      if (uris.empty?)
        # if no relevant rels_ext relationships
        return nil
      end
      return ActiveFedora::Base.pids_from_uris(uris)
    end  


    def self.get_relations(id, related_id)

      x,y = String.new
      # strip off beginning & ending quotes.... ASSUME Id does NOT have beginning or ending quotes
      id.gsub(/^("|')*/,"").gsub!(/("|')*$/,"")
      begin
        # verify id exists
        x = ActiveFedora::Base.find(:id => id.to_s).first
      rescue ActiveFedora::ObjectNotFoundError
        # print "Problem finding entity with id=#{id}"
        return nil
      rescue
        return nil
      end 
      if (x.object_relations.nil?)
        return nil
      end
      begin
        # verify related_id exists
        y = ActiveFedora::Base.find(:id => related_id.to_s).first
      rescue ActiveFedora::ObjectNotFoundError
        # print "Problem finding entity with related_id=#{id}"
        return nil
      rescue
        return nil
      end 
      if (y.internal_uri.nil?)
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


    def self.retrieve_ids_associated_with_id_solr(id)
      id_info = get_info(id)
      if (!id_info.nil?)
         return retrieve_ids_associated_with_uri_solr(id_info[2], id_info[1])
      end 
      # if end up here, no match
      # print "Problem finding related premis entity ids with main_id=#{id}"
      return nil
    end


    def self.get_info(id)
      # class method that determines information based on id, returns an array as follows:
      #   1. model- (Agent, Event, FileObject, RightsStatement, RepresentationObject)
      #   2. relation associated with id- (linking_agent, linking_event, linking_object, linking_rights_statement, linking_folder_object)
      #   3. uri associate with id
      begin
        x = ActiveFedora::Base.find(:id => id.to_s).first
      rescue ActiveFedora::ObjectNotFoundError
        # print "Problem finding entity with id=#{id}"
        return nil
      rescue
        return nil
      end 
      if (x.object_relations.nil?)
        return nil
      end
      x.object_relations.relationships[:has_model].each do |y|
        case y
          when "info:fedora/afmodel:MedusaPremis_Agent"
            return ["Agent", "linking_agent", x.internal_uri]
          when "info:fedora/afmodel:MedusaPremis_Event"
            return ["Event", "linking_event", x.internal_uri]
          when "info:fedora/afmodel:MedusaPremis_FileObject"
            return ["FileObject", "linking_object", x.internal_uri]
          when "info:fedora/afmodel:MedusaPremis_RightsStatement"
            return ["RightsStatement", "linking_rights_statement", x.internal_uri]
          when "info:fedora/afmodel:MedusaPremis_RepresentationObject"
            return ["RepresentationObject", "linking_folder_object", x.internal_uri]
          when "info:fedora/fedora-system:FedoraObject-3.0"
            # default 
        end
      end
      # if end up here, no match
      # print "Problem finding properly named premis entity with id=#{id}"
      return nil
    end


    def self.retrieve_ids_associated_with_uri_solr(uri, relation)
      # retrieve as array.  If no ids, return nil
      #    retrieve from SOLR...
      all_objs = ActiveFedora::Base.find("#{relation}_ssim"=>uri.to_s)
      if all_objs.nil? or all_objs.empty?
        # either uri is NOT related to any entity OR uri is NOT associated with the specified relation
        return nil
      else
        ids = all_objs.map do |x|
          x.pid
        end
        return ids
      end
    end




   ##########################   NOT USED ###############################################


    def self.retrieve_ids_associated_with_all_events
      # retrieve as array.  If no ids, return nil
      results = []
      ActiveFedora::Base.find_each("linking_event_ssim:*") do |x|
        results << x.pid
      end
      if results.nil? or results.empty?
        return nil
      end
      return results
    end


    def retrieve_event_ids
      # retrieve all events associated with given premis entity... as array
      #    retrieve from Fedora...
      # if no events, return nil
      self.object_relations.relationships[:linking_event].empty? ? (return nil) : (return ActiveFedora::Base.pids_from_uris(self.object_relations.relationships[:linking_event]))  
    end

    def attach_event(id) 
      # assumes model can attach event.  TODO: run checks so that only certain models can run this method
      # for testing...
      # print "id=#{id}\n"
      if id.nil?
        # if no id event with which to create an event attached to this entity... create default event
        pe = MedusaPremis::Event.create
      else
        # first make sure this id is an event object 
        begin
          pe = MedusaPremis::Event.find(:id => id.to_s).first
        rescue ActiveFedora::ObjectNotFoundError
          print "Problem finding Event with id=#{id}" 
        end
      end
      if (!pe.nil?)
        begin
          a.add_relationship(:linking_event, pe.internal_uri)
          self.save!
          # Note: relationship is explicitly bidirectional
        rescue
          print "Problem: Event cannot be added to #{self.class.inspect}.\n"
        end 
      else
        # TODO: if Premis Event does not exist for that particular id
      end
    end

  end
end
