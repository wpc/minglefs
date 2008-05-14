module MingleFs
  module Commands
    class Load < CommandLine::Command
      LOADERS = {
        'eval:' => lambda {|args| eval(args.join(" ")) },
        'rest:' => lambda {|args| Mingle::Card.find(:all) }
      }
      
      def self.aliases
        ['l', 'load']
      end
      
      def execute(*args)
        loader = LOADERS[args.shift] || raise('unknown type of loader')
        context.repository.push(*(loader.call(args)))
      end
    end
  end
end