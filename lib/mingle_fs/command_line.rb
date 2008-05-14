module MingleFs
  class CommandLine
    class UnknowCommand < Struct.new(:context)
      def execute(*args)
        puts 'unknown command'
      end
    end
    
    class Command < Struct.new(:context)
      def self.inherited(subclass)
        CommandLine.register(subclass)
      end
    end
    
    @@commands = []
    
    def self.register(command)
      @@commands << command
    end
    
    def initialize(context)
      @context = context
    end
  
    def run
      while line = $stdin.gets
        cmd, args = parse(line)
        begin
          cmd.execute(*args)
          $stdout.puts 'OK'
          $stdout.flush
        rescue  => e
          p e
        end
      end
    end
  
    def parse(line)
      command_name, *rest = line.split(/\s+/)
      command = @@commands.detect{ |c| c.aliases.include?(command_name) } 
      command ||= UnknowCommand
      return command.new(@context), rest
    end
  end
end