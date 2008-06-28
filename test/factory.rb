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
    attributes
  end
  
  # Build an unsaved record
  def new_record(model, *args)
    model.new(valid_attributes_for(model, *args))
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
    attributes.reverse_merge!(
      :region => 'US-CA',
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
      :id => 123,
      :name => 'Moon',
      :official_name => 'The Moon',
      :alpha_2_code => 'GC',
      :alpha_3_code => 'MOO'
    )
  end
  
  build Region do |attributes|
    attributes.reverse_merge!(
      :id => 123,
      :country => 'US',
      :name => 'New Something',
      :abbreviation => 'NS'
    )
  end
end
