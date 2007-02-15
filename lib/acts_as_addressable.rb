require 'acts_association_helper'
require 'validates_xor_presence_of'

module PluginAWeek #:nodoc:
  module Acts #:nodoc:
    module Addressable #:nodoc:
      def self.included(base) #:nodoc:
        base.extend(MacroMethods)
      end
      
      module MacroMethods
        # 
        def acts_as_addressable(*args, &extension)
          default_options = {
            :count => :one
          }
          create_acts_association(:address, default_options, *args, &extension)
          
          extend PluginAWeek::Acts::Addressable::ClassMethods
          include PluginAWeek::Acts::Addressable::InstanceMethods
        end
      end
      
      module ClassMethods #:nodoc:
      end
      
      module InstanceMethods #:nodoc:
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  include PluginAWeek::Acts::Addressable
end