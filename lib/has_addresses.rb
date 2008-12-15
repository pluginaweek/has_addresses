# Adds a generic implementation for dealing with regions, countries, and
# addresses
module HasAddresses
  module MacroMethods
    # Creates the following association:
    # * +addresses+ - All addresses associated with the current record.
    def has_addresses
      has_many  :addresses,
                  :as => :addressable
    end
  end
end

ActiveRecord::Base.class_eval do
  extend HasAddresses::MacroMethods
end
