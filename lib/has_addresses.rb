module PluginAWeek #:nodoc:
  module Has #:nodoc:
    # Adds base models for interacting with addresses, including Country,
    # Region, and Address.  These have the minimal attribute definitions needed
    # to store addresses.
    module Addresses
      # Whether or not to use verbose output
      mattr_accessor :verbose
      @@verbose = true
      
      def self.included(base) #:nodoc:
        base.extend(MacroMethods)
      end
      
      module MacroMethods
        # Creates a new association for having a single address.  This takes
        # the same parameters as ActiveRecord::Associations::ClassMethods#has_one.
        # By default, the following associations are the same:
        # 
        #   class Person < ActiveRecord::Base
        #     has_address
        #   end
        # 
        # and
        # 
        #   class Person < ActiveRecord::Base
        #     has_one :address,
        #               :class_name => 'Address',
        #               :as => :addressable,
        #               :dependent => :destroy
        #   end
        def has_address(*args, &extension)
          create_address_association(:one, :address, *args, &extension)
        end
        
        # Creates a new association for having a multiple addresses.  This takes
        # the same parameters as ActiveRecord::Associations::ClassMethods#has_many.
        # By default, the following associations are the same:
        # 
        #   class Person < ActiveRecord::Base
        #     has_addresses
        #   end
        # 
        # and
        # 
        #   class Person < ActiveRecord::Base
        #     has_many  :addresses,
        #                 :class_name => 'Address',
        #                 :as => :addressable,
        #                 :dependent => :destroy
        #   end
        def has_addresses(*args, &extension)
          create_address_association(:many, :addresses, *args, &extension)
        end
        
        private
        def create_address_association(cardinality, association_id, *args, &extension)
          options = extract_options_from_args!(args)
          options.symbolize_keys!.reverse_merge!(
            :class_name => 'Address',
            :as => :addressable,
            :dependent => :destroy
          )
          
          send("has_#{cardinality}", args.first || association_id, options, &extension)
        end
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  include PluginAWeek::Has::Addresses
end
