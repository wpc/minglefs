require File.expand_path(File.dirname(__FILE__) + '/functional_helper')

class CommandEvalTest < Test::Unit::TestCase
  
  def setup
    @console = open_mingle_fs
  end

  def test_eval_arbitary_ruby_code
    @console.input %{e puts 'hello world'}
    assert_equal 'hello world', @console.output
    @console.assert_success
  end
  
  def test_context_should_be_in_the_eval_binding
    @console.input %{e p context != nil }
    assert_equal 'true', @console.output
  end
end