require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class CommandLineTest < Test::Unit::TestCase
  class SampleCommand < CommandLine::Command
    def self.aliases
      ['sample']
    end
  end
  
  def setup
    @context = OpenStruct.new
    @command_line = CommandLine.new(@context)
  end
  
  def test_command_should_be_generated_if_match_any_command_subclass
    command = @command_line.parse('sample').first
    assert_equal SampleCommand, command.class
  end
  
  def test_unknown_command_should_be_generated_if_dont_know_how_to_parse_command
    command = @command_line.parse('xxxxx dfij').first
    assert_equal CommandLine::UnknowCommand, command.class
  end
  
  def test_should_take_term_after_command_as_args
    args = @command_line.parse('sample dfij allal').last
    assert_equal ['dfij', 'allal'], args
  end
  
end