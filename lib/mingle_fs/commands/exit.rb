module MingleFs
  module Commands
    class Exit < CommandLine::Command
      def self.aliases
        ['exit', 'quite']
      end
      
      def execute
        context.fs.umount
        exit
      end
    end
  end
end