module Factory
  # Build actions for the model
  def self.build(model, &block)
    name = model.to_s.underscore
    
    define_method("#{name}_attributes", block)
    define_method("valid_#{name}_attributes") {|*args| valid_attributes_for(model, *args)}
    define_method("new_#{name}")              {|*args| new_record(model, *args)}
    define_method("create_#{name}")           {|*args| create_record(model, *args)}
  end
  
  # Get valid attributes for the model
  def valid_attributes_for(model, attributes = {})
    name = model.to_s.underscore
    send("#{name}_attributes", attributes)
    attributes.stringify_keys!
    attributes
  end
  
  # Build an unsaved record
  def new_record(model, *args)
    attributes = valid_attributes_for(model, *args)
    record = model.new(attributes)
    attributes.each {|attr, value| record.send("#{attr}=", value) if model.accessible_attributes && !model.accessible_attributes.include?(attr) || model.protected_attributes && model.protected_attributes.include?(attr)}
    record
  end
  
  # Build and save/reload a record
  def create_record(model, *args)
    record = new_record(model, *args)
    record.save!
    record.reload
    record
  end
  
  build Address do |attributes|
    attributes[:addressable] = create_company unless attributes.include?(:addressable)
    attributes[:region] = create_region(attributes.slice(:country)) unless attributes.include?(:region)
    attributes.reverse_merge!(
      :street_1 => '1600 Amphitheatre Parkway',
      :city => 'Mountain View',
      :postal_code => '94043'
    )
  end
  
  build Company do |attributes|
    attributes.reverse_merge!(
      :name => 'Google'
    )
  end
  
  build Country do |attributes|
    attributes.reverse_merge!(
      :name => 'United States',
      :official_name => 'United States of America',
      :alpha_2_code => 'US',
      :alpha_3_code => 'USA'
    )
  end
  
  build Region do |attributes|
    attributes[:country] = create_country unless attributes.include?(:country)
    attributes.reverse_merge!(
      :name => 'California',
      :abbreviation => 'CA'
    )
  end
end
