module MingleFs
  class FileSystem
    def initialize(root, repository)
      @root = root
      @repository = repository
    end
    
    def contents(path)
      @repository.all.collect{ |card| card.as_file }.unshift('status.txt')
    end
  
    def file?(path)
      path != '/'
    end
    
    def directory?(path)
      path == '/'      
    end
  
    def read_file(path)
     if number = Mingle::Card.extract_number(path)
       begin
         @repository.for_number(number).description
       rescue IndexableNotFound => e
         "sorry, can not find card matching #{path} on remote server"
       end
     end
    end
  
    def size(path)
      read_file(path).size
    end
    
    def mount
      @fuse_pid = fork do
        FuseFS.set_root(self)
        FuseFS.mount_under(@root, 'ping_diskarb,volname=Mingle')
        FuseFS.run
      end
      
      wait_for_status_file_appear
    end
    
    def umount
      Process.kill(9, @fuse_pid) if @fuse_pid
      system("umount #{@root}")
    end
    
    private
    
    def wait_for_status_file_appear
      timeout(7) do
        sleep(0.1) until File.exist?(status_file) 
      end
    end
    
    def status_file
      File.join(@root, 'status.txt')
    end
  end
end