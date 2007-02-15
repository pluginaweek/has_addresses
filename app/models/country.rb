# Defined by the ISO 3166-1 standard
class Country < ActiveRecord::Base
  has_many                  :regions
  has_many                  :addresses
  
  validates_presence_of     :name,
                            :alpha_2_code
                            
  validates_uniqueness_of   :name,
                            :alpha_2_code,
                            :alpha_3_code
                            
  validates_length_of       :name,
                              :within => 2..80
  validates_length_of       :alpha_2_code,
                              :is => 2
  validates_length_of       :alpha_3_code,
                              :is => 3
  
  validates_inclusion_of    :calling_code,
                              :in => 1..999
  
  alias_attribute :abbreviation_2, :alpha_2_code
  alias_attribute :abbreviation_3, :alpha_3_code
  
  # Returns the name of the country
  def to_s #:nodoc
    name
  end
end