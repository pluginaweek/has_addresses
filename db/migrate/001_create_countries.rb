class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.column :name,           :string, :limit => 80,  :null => false
      t.column :abbreviation_2, :string, :limit => 2,   :null => false
      t.column :abbreviation_3, :string, :limit => 3,   :null => false
      t.column :calling_code,   :string, :limit => 3
    end
    add_index :countries, :name,            :unique => true
    add_index :countries, :abbreviation_2,  :unique => true
    add_index :countries, :abbreviation_3,  :unique => true
  end
  
  def self.down
    drop_table_if_exists :countries
  end
  
  def self.bootstrap
    :countries
  end
end
