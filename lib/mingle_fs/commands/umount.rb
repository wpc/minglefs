module MingleFs
  module Commands
    class UMount < CommandLine::Command
      def self.aliases
        ['umount']
      end
      
      def execute(*args)
        context.fs.umount
      end
    end
  end
end