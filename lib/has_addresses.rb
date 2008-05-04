module PluginAWeek #:nodoc:
  # Adds a generic implementation for dealing with regions, countries, and
  # addresses
  module HasAddresses
    def self.included(base) #:nodoc:
      base.class_eval do
        extend PluginAWeek::HasAddresses::MacroMethods
      end
    end
    
    module MacroMethods
      # Creates the following association:
      # * +addresses+ - All addresses associated with the current record.
      def has_addresses
        has_many  :addresses
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  include PluginAWeek::HasAddresses
end
