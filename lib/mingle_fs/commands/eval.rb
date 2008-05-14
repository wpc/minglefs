module MingleFs
  module Commands
    class Eval < CommandLine::Command
      def self.aliases
        ['e', 'eval']
      end
      
      def execute(*script)
        eval(script.join(' '))
      end
    end
  end
end