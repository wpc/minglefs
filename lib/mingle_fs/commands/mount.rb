module MingleFs
  module Commands
    class Mount < CommandLine::Command
      def self.aliases
        ['mount']
      end
      
      def execute(*args)
        mount_point = args.first
        context.fs = FileSystem.new(mount_point, context.repository)
        context.fs.mount
      end
    end
  end
end