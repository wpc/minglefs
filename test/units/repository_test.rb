require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class RepositoryTest < Test::Unit::TestCase
  class MemPersistence < Hash
    attr_reader :transaction_count
    def initialize
      @transaction_count = 0
    end
    
    def transaction(&block)
      @transaction_count += 1
      yield
    end
  end
  
  def setup
    @persistence = MemPersistence.new
    @repo = Repository.new(@persistence)
    @i1, @i2 = [OpenStruct.new(:number => 1), OpenStruct.new(:number => 2)]
  end
  
  def test_after_push_indexable_objects_should_be_able_to_get_all_them_out
    @repo.push @i1, @i2
    assert_equal 2, @repo.size
    assert_equal [1, 2], @repo.all.collect(&:number)
  end
  
  def test_should_write_to_persistence_within_transaction_each_time_push
    @repo.push @i1, @i2
    assert_equal 1, @persistence.transaction_count
    @repo.push @i2
    assert_equal 2, @persistence.transaction_count
  end
  
  def test_should_be_able_get_indexable_object_out_by_number
    @repo.push @i1, @i2
    assert_equal @i1, @repo.for_number(1)
    assert_equal @i2, @repo.for_number(2)
  end
  
  def test_should_raise_not_found_error_when_try_to_locate_not_exist_indexable
    assert_raise(Repository::IndexableNotFound) { @repo.for_number(1) }
  end
end