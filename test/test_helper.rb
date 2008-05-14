$:.unshift File.dirname(__FILE__) + '/../lib'
require 'test/unit'
require 'mingle_fs'

MNT = File.dirname(__FILE__) + '/../mnt'

class Test::Unit::TestCase
  include MingleFs
end