class CreditCard < ActiveRecord::Base
  acts_as_addressable :count => :one
end