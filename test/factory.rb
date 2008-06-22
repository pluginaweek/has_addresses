module Factory
  # Build actions for the class
  def self.build(klass, &block)
    name = klass.to_s.underscore
    define_method("#{name}_attributes", block)
    
    module_eval <<-end_eval
      def valid_#{name}_attributes(attributes = {})
        #{name}_attributes(attributes)
        attributes
      end
      
      def new_#{name}(attributes = {})
        #{klass}.new(valid_#{name}_attributes(attributes))
      end
      
      def create_#{name}(*args)
        record = new_#{name}(*args)
        record.save!
        record.reload
        record
      end
    end_eval
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
