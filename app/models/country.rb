# Defined by the ISO 3166 standard
#
class Country < ActiveRecord::Base
  has_many                  :regions
  has_many                  :addresses
  
  validates_presence_of     :name,
                            :abbreviation_2
                            
  validates_uniqueness_of   :name,
                            :abbreviation_2,
                            :abbreviation_3
                            
  validates_length_of       :name,
                              :within => 2..80
  validates_length_of       :abbreviation_2,
                              :is => 2
  validates_length_of       :abbreviation_3,
                              :is => 3
  
  validates_inclusion_of    :calling_code,
                              :in => 1..999
  
  # Returns the name of the country
  #
  def to_s #:nodoc
    name
  end
end