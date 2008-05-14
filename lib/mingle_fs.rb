require 'fusefs'
require 'ostruct'
require 'timeout'
require 'mingle_fs/cards'
require 'mingle_fs/pstore_persistence'
require 'mingle_fs/repository'
require 'mingle_fs/command_line'

Dir[File.dirname(__FILE__) + '/mingle_fs/commands/**/*.rb'].each do |command| 
  require 'mingle_fs/commands/' + File.basename(command)
end

require 'mingle_fs/file_system'


module MingleFs

  def start
    MingleFs::Mingle::Card.site = "http://pwang:pass@localhost:8080/projects/mingle"
    pstore_repository = Repository.new(PStorePersistence.new)
    context = OpenStruct.new(:repository => pstore_repository)    
    CommandLine.new(context).run
  end
  
  module_function :start
end