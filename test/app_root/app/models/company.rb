class Company < ActiveRecord::Base
  has_address :headquarters_address,
                :conditions => ['addresses.kind = ?', 'headquarters']
  has_address :sales_address,
                :conditions => ['addresses.kind = ?', 'sales']
  has_addresses
end