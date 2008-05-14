require 'pstore'
require 'delegate'
require 'fileutils'

module MingleFs
  class PStorePersistence < DelegateClass(PStore)
    STORE_FILE = '.minglefs.persistence'
    
    def initialize
      @store = PStore.new(STORE_FILE)
      super(@store)
    end
        
    def [](key)
      read_transaction { @store[key] }
    end
    
    def size
      values.size
    end
    
    def clean
      FileUtils.rm_f STORE_FILE
    end
    
    def values
      read_transaction { @store.roots.collect { |key| @store[key] }}
    end
    
    private
    def read_transaction(&block)
      @store.transaction(true, &block)
    end
  end
end