require File.expand_path(File.dirname(__FILE__) + '/functional_helper')

class CommandLoadTest < Test::Unit::TestCase
  def setup
    @console = open_mingle_fs
  end
  
  def test_loaded_card_should_goes_to_repository_of_context
    @console.input %{load eval: [Mingle::Card.new(:number => 1, :name => 'story1')]}
    @console.assert_success
    
    @console.input %{e puts context.repository.for_number(1).name }
    assert_equal 'story1', @console.output
    @console.assert_success
  end
  
end