module MedusaPremis
  module Datastream

    require 'open3'
    class FileContentDs < ActiveFedora::Datastream
      include Open3
    end

  end
end
