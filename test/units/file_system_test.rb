require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class FileSystemTest < Test::Unit::TestCase
  
  def test_after_mount_in_mnt_dir_should_show_status_file
    fs = FileSystem.new(MNT, OpenStruct.new(:all => []))
    fs.mount    
    assert File.exist?(File.join(MNT, 'status.txt'))
  ensure
    fs.umount
  end
end