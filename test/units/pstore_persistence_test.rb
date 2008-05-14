require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class PStorePersistenceTest < Test::Unit::TestCase
  def setup
    @persistence = PStorePersistence.new
    @persistence.clean
  end
  
  def teardown
    @persistence.clean
  end
  
  def test_set_and_get
    assert_nil @persistence[:a]
    @persistence.transaction do 
      @persistence[:a] = :x
    end
    assert_equal :x, @persistence[:a]
  end
  
  def test_size
    assert_equal 0, @persistence.size
    @persistence.transaction do 
      @persistence[:a] = :x
      @persistence[:b] = :y
    end
    assert_equal 2, @persistence.size
  end
  
  def test_assign_with_same_key_should_replace_old_obj
    @persistence.transaction do 
      @persistence[:a] = :x
    end
    
    @persistence.transaction do
      @persistence[:a] = :y
    end
    
    assert_equal :y, @persistence[:a]
  end
  
  def test_values_should_return_all_objects
    assert_equal [], @persistence.values
    @persistence.transaction do 
      @persistence[:a] = 'x'
      @persistence[:b] = 'y'
    end
    assert_equal ['x', 'y'].sort, @persistence.values.sort
  end
  
end