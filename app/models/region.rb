require 'open-uri'
require 'cgi'
require 'rexml/document'

# Defined by the ISO 3166-2 standard.  This is a standard that gives short codes
# for provinces, etc. within a country.
class Region < ActiveRecord::Base
  # The url of the open source version of the ISO 3166-2 standard
  ISO_3166_2_URL = 'http://svn.debian.org/wsvn/pkg-isocodes/trunk/iso-codes/iso_3166/iso_3166_2/iso_3166_2.xml?op=file'
  
  class << self
    # Creates a fixtures containing all possible regions
    def create_fixtures(output_file_path = nil)
      output_file_path ||= 'db/bootstrap/regions.yml'
      output_file_path = File.join(RAILS_ROOT, output_file_path)
      
      FileUtils.mkdir_p(File.dirname(output_file_path))
      output_file = File.new(output_file_path, File::CREAT|File::TRUNC|File::RDWR)
      output = ''
      
      download_all.each do |region|
        record_name = region.name.gsub(' ', '_').gsub(/[^A-Za-z_]/, '').downcase
        
        output << "#{record_name}:\n"
        region.attributes.each do |attr, value|
          output << "  #{attr}: #{value}\n" if value
        end
      end
      
      output_file << output.slice(0..output.length-2)
      output_file.close
      
      true
    end
    
    # Bootstraps the table by downloading the latest ISO 3166-2 standard and
    # saving each region to the database
    def bootstrap
      delete_all
      download_all.each {|region| region.save!}
      
      true
    end
    
    # Downloads the latest ISO 3166-2 standard and returns the data as a list of
    # regions
    def download_all
      countries = Country.download_all
      alpha_2_code_to_country = Hash[*countries.collect {|c| [c.alpha_2_code, c]}.flatten]
      
      # Download the standard
      iso_3166_2 = open(ISO_3166_2_URL).readlines * "\n"
      iso_3166_2 = CGI::unescapeHTML(/<pre>(.+)<\/pre>/im.match(iso_3166_2)[1].gsub('&nbsp;', ''))
      
      # Parse and load the regions
      region_id = 1
      regions = []
      REXML::Document.new(iso_3166_2).elements.each('*/iso_3166_country') do |country|
        code = country.attributes['code'][0..1] # Belarius is more than 2 characters for some reason, so just get the first 2
        country_record = alpha_2_code_to_country[code.upcase]
        
        country.elements.each('iso_3166_2_entry') do |region|
          name = region.attributes['name'].to_s.gsub("'","\\'").strip
          abbreviation = region.attributes['code'].upcase.sub("#{code}-", '')
          
          region = new(
            :country_id => country_record.id,
            :name => name,
            :abbreviation => abbreviation
          )
          region.id = region_id
          
          if !country_record.regions.any? {|known_region| known_region.name == region.name}
            regions << region
            country_record.regions << region 
            region_id += 1
          end
        end
      end
      
      regions
    end
  end
  
  belongs_to  :country
  has_many    :addresses
  
  validates_presence_of   :name,
                          :country_id,
                          :abbreviation
  validates_length_of     :name,
                            :within => 2..80
  validates_length_of     :abbreviation,
                            :within => 1..5
  validates_uniqueness_of :name,
                            :scope => :country_id
  validates_uniqueness_of :abbreviation,
                            :scope => :country_id
  
  def to_s #:nodoc
    name
  end
end
