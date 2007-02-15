namespace :iso3166 do
  namespace :countries do
    desc 'Generates a new bootstrap file for the countries table'
    task :create do
      require 'uri'
      require 'net/http'
      require 'cgi'
      require 'rexml/document'
      
      include REXML
      
      output_file_name = ENV['OUTPUT'] || ENV['COUNTRIES_OUTPUT'] || 'db/bootstrap/countries.yml'
      
      # Get calling codes
      calling_codes = Net::HTTP.get(URI.parse('http://en.wikipedia.org/w/index.php?title=List_of_country_calling_codes&action=edit'))
      alpha_2_code_to_calling_code = Hash.new
      
      regex_phone = /'''\+([0-9]{1,3}):'''/
      calling_codes.split("\n") do |line|
        line = line.strip
        match = regex_phone.match( line )
        
        if match then
          calling_code = match[1]
          
          line.scan(/\|[A-Z]{2}\]/).each do |alpha_2_code|
            alpha_2_code_to_calling_code[alpha_2_code.slice(1,2)] = calling_code
          end
        end
      end
      
      # Get the countries
      iso_3166_1 = Net::HTTP.get(URI.parse('http://svn.debian.org/wsvn/pkg-isocodes/trunk/iso-codes/iso_3166/iso_3166.xml?op=file&rev=0&sc=1'))
      iso_3166_1 = CGI::unescapeHTML(/<pre>(.+)<\/pre>/im.match(iso_3166_1)[1].gsub('&nbsp;', ''))
      
      output_file = File.new(output_file_name, 'w')
      output = ''
      
      Document.new(iso_3166_1).elements.each('*/iso_3166_entry') do |country|
        name = country.attributes['name']
        official_name = country.attributes['official_name']
        alpha_2_code = country.attributes['alpha_2_code'].upcase
        alpha_3_code = country.attributes['alpha_3_code'].upcase
        country_id = country.attributes['numeric_code'].to_i
        calling_code = alpha_2_code_to_calling_code[alpha_2_code]
        record_name = name.gsub(' ', '_').gsub(/[^A-Za-z_]/, '').downcase
        
        # Prepare for yml
        name.gsub!("'","\\'")
        official_name.gsub!("'", "\\'") if official_name
        
        output << "#{record_name}:\n"
        output << "  id: #{country_id}\n"
        output << "  name: #{name}\n"
        output << "  official_name: #{official_name}\n" if official_name
        output << "  alpha_2_code: #{alpha_2_code}\n"
        output << "  alpha_3_code: #{alpha_3_code}\n"
        output << "  calling_code: #{calling_code}\n" if calling_code
      end
      
      output_file << output.slice(0..output.length-2)
    end
  end
  desc ''
  
  namespace :regions do
    desc 'Generates a new bootstrap file for the regions table'
    task :create do
      require 'uri'
      require 'net/http'
      require 'cgi'
      require 'rexml/document'
      
      include REXML
      
      output_file_name = ENV['OUTPUT'] || ENV['REGIONS_OUTPUT'] || 'db/bootstrap/regions.yml'
      
      # Get the countries for id reference
      iso_3166_1 = Net::HTTP.get(URI.parse('http://svn.debian.org/wsvn/pkg-isocodes/trunk/iso-codes/iso_3166/iso_3166.xml?op=file&rev=0&sc=1'))
      iso_3166_1 = CGI::unescapeHTML(/<pre>(.+)<\/pre>/im.match(iso_3166_1)[1].gsub('&nbsp;', ''))
      
      # Map alpha_2_code to country_id
      alpha_2_code_to_country_id = Hash.new
      Document.new(iso_3166_1).elements.each('*/iso_3166_entry') do |country|
        alpha_2_code_to_country_id[country.attributes['alpha_2_code'].upcase] = country.attributes['numeric_code'].to_i
      end
      
      # Get the regions
      iso_3166_2 = Net::HTTP.get(URI.parse('http://svn.debian.org/wsvn/pkg-isocodes/trunk/iso-codes/iso_3166/iso_3166_2/iso_3166_2.xml?op=file&rev=0&sc=1'))
      iso_3166_2 = CGI::unescapeHTML(/<pre>(.+)<\/pre>/im.match(iso_3166_2)[1].gsub('&nbsp;', ''))
      
      output_file = File.new(output_file_name, 'w')
      output = ''
      
      region_id = 1
      Document.new(iso_3166_2).elements.each('*/iso_3166_country') do |country|
        code = country.attributes['code']
        country_id = alpha_2_code_to_country_id[code.upcase]
        
        country.elements.each('iso_3166_2_entry') do |region|
          name = region.attributes['name']
          abbreviation = region.attributes['code'].upcase.sub!("#{code}-", '')
          record_name = name.gsub(' ', '_').gsub(/[^A-Za-z_]/, '').downcase
          
          # Prepare for yml
          name.gsub!("'","\\'")
          
          output << "#{record_name}:\n"
          output << "  id: #{region_id}\n"
          output << "  country_id: #{country_id}\n"
          output << "  name: #{name}\n"
          output << "  abbreviation: #{abbreviation}\n"
          
          region_id += 1
        end
      end
      
      output_file << output.slice(0..output.length-2)
    end
  end
  
  desc 'Generates new bootstrap files for countries and regions'
  task :create_all => [:countries, :regions] do
  end
end