require 'open-uri'
require 'cgi'
require 'rexml/document'

# Defined by the ISO 3166 standard.  The ISO 3166 standard includes a
# "Country Subdivision Code", giving a code for the names of the principal
# administrative subdivisions of the countries coded in ISO 3166.
class Country < ActiveRecord::Base
  # The url of the open source version of the ISO 3166 standard
  ISO_3166_URL = 'http://svn.debian.org/wsvn/pkg-isocodes/trunk/iso-codes/iso_3166/iso_3166.xml?op=file'
  
  class << self
    # Creates a fixtures file containing all possible countries
    def create_fixtures(output_file_path = nil)
      output_file_path ||= 'db/bootstrap/countries.yml'
      output_file_path = File.join(RAILS_ROOT, output_file_path)
      
      FileUtils.mkdir_p(File.dirname(output_file_path))
      output_file = File.new(output_file_path, File::CREAT|File::TRUNC|File::RDWR)
      output = ''
      
      countries = download_all
      puts "Saving countries to #{output_file_path}..." if PluginAWeek::Has::Addresses.verbose
      countries.each do |country|
        record_name = country.name.gsub(' ', '_').gsub(/[^A-Za-z_]/, '').downcase
        
        output << "#{record_name}:\n"
        country.attributes.each do |attr, value|
          output << "  #{attr}: #{value}\n" if value
        end
      end
      
      output_file << output.slice(0..output.length-2)
      output_file.close
      
      puts 'Done!' if PluginAWeek::Has::Addresses.verbose
      true
    end
    
    # Bootstraps the table by downloading the latest ISO 3166 standard and
    # saving each country to the database
    def bootstrap
      countries = download_all
      
      puts 'Loading countries into database...' if PluginAWeek::Has::Addresses.verbose
      delete_all
      countries.each {|country| country.save!}
      
      puts 'Done!' if PluginAWeek::Has::Addresses.verbose
      true
    end
    
    # Downloads the latest ISO 3166 standard and returns the data as a list of
    # countries
    def download_all
      # Download the standard
      puts 'Downloading ISO 3166 data...' if PluginAWeek::Has::Addresses.verbose
      iso_3166 = open(ISO_3166_URL).readlines * "\n"
      iso_3166 = CGI::unescapeHTML(/<pre>(.+)<\/pre>/im.match(iso_3166)[1].gsub('&nbsp;', ''))
      
      # Parse and load the countries
      puts 'Parsing countries...' if PluginAWeek::Has::Addresses.verbose
      countries = []
      REXML::Document.new(iso_3166).elements.each('*/iso_3166_entry') do |country|
        name = country.attributes['name'].to_s.gsub("'","\\'")
        official_name = country.attributes['official_name']
        official_name = official_name.to_s.gsub!("'", "\\'") if official_name
        alpha_2_code = country.attributes['alpha_2_code'].to_s.upcase
        alpha_3_code = country.attributes['alpha_3_code'].to_s.upcase
        country_id = country.attributes['numeric_code'].to_s.to_i
        record_name = name.gsub(' ', '_').gsub(/[^A-Za-z_]/, '').downcase
        
        country = new(
          :name => name,
          :official_name => official_name,
          :alpha_2_code => alpha_2_code,
          :alpha_3_code => alpha_3_code
        )
        country.id = country_id
        countries << country
      end
      
      countries
    end
  end
  
  has_many  :regions
  
  validates_presence_of   :name,
                          :alpha_2_code,
                          :alpha_3_code
  validates_uniqueness_of :name,
                          :alpha_2_code,
                          :alpha_3_code
  validates_length_of     :name,
                            :within => 2..80
  validates_length_of     :alpha_2_code,
                            :is => 2
  validates_length_of     :alpha_3_code,
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
