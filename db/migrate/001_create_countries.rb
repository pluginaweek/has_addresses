class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.column :name, :string, :null => false, :limit => 80
      t.column :official_name, :string, :limit => 80
      t.column :alpha_2_code, :string, :null => false, :limit => 2
      t.column :alpha_3_code, :string, :null => false, :limit => 3
    end
    add_index :countries, :name, :unique => true
    add_index :countries, :alpha_2_code, :unique => true
    add_index :countries, :alpha_3_code, :unique => true
  end
  
  def self.down
    drop_table :countries
  end
end
