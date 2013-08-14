module MedusaPremis

  # models 
  autoload :General, 'medusa_premis/general'
  autoload :RightsStatement, 'medusa_premis/rights_statement'
  autoload :Agent, 'medusa_premis/agent'
  autoload :Event, 'medusa_premis/event'
  autoload :FileObject, 'medusa_premis/file_object'
  autoload :RepresentationObject, 'medusa_premis/representation_object'

  # datastreams 
  module Datastream
    autoload :FileContentDs, 'medusa_premis/datastream/file_content_ds'
    autoload :RightsStatementDs, 'medusa_premis/datastream/rights_statement_ds'
    autoload :AgentDs, 'medusa_premis/datastream/agent_ds'
    autoload :EventDs, 'medusa_premis/datastream/event_ds'
    autoload :FileObjectDs, 'medusa_premis/datastream/file_object_ds'
    autoload :RepresentationObjectDs, 'medusa_premis/datastream/representation_object_ds'
  end

end


