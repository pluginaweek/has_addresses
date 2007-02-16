# Represents a mailing address
class Address < ActiveRecord::Base
  belongs_to          :addressable,
                        :polymorphic => true
  belongs_to          :region
  belongs_to          :country
  
  validates_format_of :postal_code,
                        :with => /[0-9]{5}/,
                        :allow_nil => true
  before_save         :ensure_exclusive_references
  
  # Returns the region's country if the region is specified
  def country_with_region_check
    region ? region.country : country_without_region_check
  end
  alias_method_chain :country, :region_check
  
  # Gets the name of the region that this address is for (whether it is a custom or
  # stored region in the database)
  def region_name
    custom_region || region ? region.name : nil
  end
  
  # Gets the value of the address on a single line
  def single_line
    multi_line.join(', ')
  end
  
  # Gets the value of the address on multiple lines
  def multi_line
    lines = []
    lines << street_1 if street_1?
    lines << street_2 if street_2?
    
    line = ''
    line << city if city?
    if region_name
      line << ', ' if !last_line.blank?
      line << region_name
    end
    if postal_code?
      line << '  ' if !last_line.blank?
      line << postal_code
    end
    lines << line if !line.blank?
    
    lines << country.name if country
    
    lines
  end
  
  private
  # Ensures that the country id/user region combo is not set at the same time as
  # the region id
  def ensure_exclusive_references
    if region_id?
      self.country_id = nil
      self.custom_region = nil
    end
    
    true
  end
end