begin
  require 'active_resource'
rescue LoadError
  require 'rubygems'
  require 'active_resource'
end

module MingleFs
  module Mingle
    class Card < ActiveResource::Base
      def self.extract_number(str)
        if str =~ /\/#(\d+)\s/
          $1.to_i
        end
      end
      
      def as_file
        "##{number} #{name}.txt"
      end
    end
  end
end