# Defined by the ISO 3166-1 standard
class Country < ActiveRecord::Base
  has_many                  :regions
  
  validates_presence_of     :name,
                            :alpha_2_code,
                            :alpha_3_code
  validates_uniqueness_of   :name,
                            :alpha_2_code,
                            :alpha_3_code
  validates_length_of       :name,
                              :within => 2..80
  validates_length_of       :alpha_2_code,
                              :is => 2
  validates_length_of       :alpha_3_code,
                              :is => 3
  
  alias_attribute :abbreviation_2, :alpha_2_code
  alias_attribute :abbreviation_3, :alpha_3_code
  
  # The official name of the country
  def official_name
    read_attribute(:official_name) || name
  end
  
  # Returns the name of the country
  def to_s #:nodoc
    name
  end
end