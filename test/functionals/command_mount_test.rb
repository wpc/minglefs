require File.expand_path(File.dirname(__FILE__) + '/functional_helper')

class CommandMountTest < Test::Unit::TestCase
  
  def setup
    @console = open_mingle_fs
  end
  
  
  def teardown
    @console.input "umount"
  end
  
  def test_mount_should_put_file_system_to_context
    @console.input "mount #{MNT}"
    @console.assert_success
    @console.input "e p context.fs != nil"
    assert_equal 'true', @console.output
  end
  
  def test_mount_should_show_all_cards_in_repository
    @console.input %{load eval: [Mingle::Card.new(:number => 1, :name => 'story1')]}
    @console.assert_success
    
    @console.input "mount #{MNT}"
    @console.assert_success
    
    card_files = Dir["#{MNT}/**/*"]
    assert_equal ["#1 story1.txt", "status.txt"].sort, card_files.collect{ |f| File.basename(f) }.sort
  end
end