require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('medusa-premis-archive-tool', '0.5.0') do |p|
  p.description     = "Create Premis MVC for Medusa Archive Project" 
  p.version         = '0.5.0'
  p.url             = "http://github.com/Rmana/medusa-premis-archive-tool"
  p.author          = "R. Manaster"
  p.email           = "manaster@illinois.edu"
  p.ignore_pattern  = ["tmp/*", "script/*"]
  p.development_dependencies = []
  p.require_paths = ["lib", "app/models", "config"]
  p.test_pattern = `ls spec/*`.split("\n") 
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
