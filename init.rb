require_plugin 'acts_association_helper'
require_plugin 'validates_xor_presence_of'

require 'acts_as_addressable'

ActiveRecord::Base.class_eval do
  include PluginAWeek::Acts::Addressable
end