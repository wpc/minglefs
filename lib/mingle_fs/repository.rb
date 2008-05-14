module MingleFs
  class Repository
    class IndexableNotFound < StandardError; end
    
    def initialize(persistence)
      @persistence = persistence
    end
    
    def push(*indexables)
      @persistence.transaction do 
        indexables.each { |indexable| @persistence[indexable.number] = indexable}
      end
    end
    
    def size
      @persistence.size
    end
    
    def all
      @persistence.values
    end
    
    def for_number(numb)
      @persistence[numb] || raise(IndexableNotFound.new("can not found indexable object with number: #{numb}"))
    end
  end  
end