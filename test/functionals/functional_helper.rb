require File.expand_path(File.dirname(__FILE__) + '/../test_helper')
class Test::Unit::TestCase
  
  class MingleFsConsole
    include Test::Unit::Assertions
    
    def initialize(pipe)
      @pipe = pipe
    end
    
    def input(str)
      @pipe.puts(str)
      @pipe.flush
    end
    
    def assert_success
      assert_equal "OK", output
    end
        
    def output
      timeout(5) do
        @pipe.gets.chomp
      end
    end
  end
  
  def open_mingle_fs
    bin = File.dirname(__FILE__) + '/../../bin/minglefs'
    start_cmd = "ruby #{bin} "
    MingleFsConsole.new(IO.popen(start_cmd, 'r+'))
  end
end