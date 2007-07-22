require 'has_association_helper'

module PluginAWeek #:nodoc:
  module Has #:nodoc:
    module Addresses #:nodoc:
      def self.included(base) #:nodoc:
        base.extend(MacroMethods)
      end
      
      module MacroMethods
        # 
        def has_address(*args, &extension)
          create_address_association(:one, *args, &extension)
        end
        
        # 
        def has_addresses(*args, &extension)
          create_address_association(:many, *args, &extension)
        end
        
        private
        def create_address_association(count, *args, &extension)
          create_has_association(count, :address, {}, *args, &extension)
        end
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  include PluginAWeek::Has::Addresses
end