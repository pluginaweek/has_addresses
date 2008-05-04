class Company < ActiveRecord::Base
  has_one   :headquarters_address,
              :as => :addressable,
              :conditions => {:kind => 'headquarters'},
              :class_name => 'Address'
  has_one   :sales_address,
              :as => :addressable,
              :conditions => {:kind => 'sales'},
              :class_name => 'Address'
  has_many  :addresses
end
