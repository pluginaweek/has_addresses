#!/usr/bin/env ruby

if ARGV.length != 5 then
  puts 'Usage: ruby parse.rb iso3166-1_file iso3166-2_file calling_codes_file iso3166-1_output iso3166-2_output'
else
  iso31661_file = ARGV[0]
  iso31662_file = ARGV[1]
  calling_codes_file = ARGV[2]

  if !File.exist?(iso31661_file) then
    puts "ISO 3166-1 file \"#{iso31661_file}\" does not exist"
  elsif !File.exist?(iso31662_file) then
    puts "ISO 3166-2 file \"#{iso31662_file}\" does not exist"
  elsif !File.exist?(calling_codes_file) then
    puts "Country code file \"#{calling_codes_file}\" does not exist"
  else
    abbrev2_to_calling_code = Hash.new
    
    regex_phone = /'''\+([0-9]{1,3}):'''/
    IO.foreach(calling_codes_file) do |line|
      line = line.strip
      match = regex_phone.match( line )
      
      if match then
        calling_code = match[1]
        
        line.scan(/\|[A-Z]{2}\]/).each do |abbrev|
          abbrev2_to_calling_code[abbrev.slice(1,2)] = calling_code
        end
      end
    end
    
    iso31661_output_file = File.new(ARGV[3], 'w')

    output = ''
    abbrev2_to_country_id = Hash.new
    country_id_to_hash = Hash.new
    country_id_to_hash['???'] = Hash.new
    country_id = 1
    
    IO.foreach(iso31661_file) do |line|
      line = line.strip 
      parts = line.split(':')
      
      if parts.length == 4 and parts[0].length > 0 and parts[1].length > 0 then
        abbrev_2 = parts[0].upcase
        abbrev_3 = parts[1].upcase
        country_name = parts[3].gsub("'", "\\'")
        country_name = parts[3]
        record_name = country_name.gsub(" ", "_").gsub(/[^A-Za-z_]/, "").downcase
        calling_code = abbrev2_to_calling_code[abbrev_2]
        
        abbrev2_to_country_id[abbrev_2] = country_id
        country_id_to_hash[country_id] = Hash.new
        output << "#{record_name}:\n"
        output << "  id: #{country_id}\n"
        output << "  name: #{country_name}\n"
        output << "  abbreviation_2: #{abbrev_2}\n"
        output << "  abbreviation_3: #{abbrev_3}\n"
        output << "  calling_code: #{calling_code}\n" if calling_code
        country_id += 1
      end
    end
    
    output = output.slice(0..output.length-2)
    iso31661_output_file << output# << ";"
    
    iso31662_output_file = File.new(ARGV[4], 'w')
    output = ''
    
    region_id = 1
    IO.foreach(iso31662_file) do |line|
      line = line.strip
      
      regex_region = /^([a-z]{2})-([a-z0-9]+)\s+(.+)/i
      match = regex_region.match( line )
      if match then
        
        country_abbrev = match[1]
        region_abbrev = match[2]
        region_name = match[3]
        
        country_id = abbrev2_to_country_id[country_abbrev]
        country_id = '???' if country_id == nil
        
        if country_id == '???' or
           country_id_to_hash[country_id][region_abbrev] == nil and
           country_id_to_hash[country_id][region_name] == nil then
           
          country_id_to_hash[country_id][region_abbrev] = 'done'
          country_id_to_hash[country_id][region_name] = 'done'
          
          record_name = region_name.gsub(' ', '_').gsub(/[^A-Za-z_]/, '').downcase
          region_name = region_name.gsub("'","\\'")
          abbrev = region_abbrev.upcase
          
          output << "#{record_name}:\n"
          output << "  id: #{region_id}\n"
          output << "  country_id: #{country_id}\n"
          output << "  name: #{region_name}\n"
          output << "  abbreviation: #{abbrev}\n"
          region_id += 1
        end
      end
      
    end
    
    output = output.slice(0..output.length-2)
    iso31662_output_file << output
  end
end