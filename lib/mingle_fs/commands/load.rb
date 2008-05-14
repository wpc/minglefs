module MingleFs
  module Commands
    class Load < CommandLine::Command
      def self.aliases
        ['l', 'load']
      end
      
      def execute(*args)
        type = args.shift
        data_script = args.join " "
        context.repository.push(*eval(data_script))
      end
    end
  end
end