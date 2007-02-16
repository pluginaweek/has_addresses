class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.column :addressable_id,   :integer,   :unsigned => true, :references => nil
      t.column :addressable_type, :string
      t.column :street_1,         :string,    :limit => 100
      t.column :street_2,         :string,    :limit => 100
      t.column :city,             :string,    :limit => 255
      t.column :region_id,        :integer,   :unsigned => true
      t.column :custom_region,    :string,    :limit => 50
      t.column :postal_code,      :string,    :limit => 5
      t.column :country_id,       :integer,   :unsigned => true, :default => 223
      t.column :created_at,       :timestamp, :null => false
      t.column :updated_at,       :datetime,  :null => false
      t.column :deleted_at,       :datetime
    end
  end
  
  def self.down
    drop_table :addresses
  end
end