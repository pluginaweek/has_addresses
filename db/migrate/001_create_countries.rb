class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :name, :official_name, :null => false
      t.string :alpha_2_code, :null => false, :limit => 2
      t.string :alpha_3_code, :null => false, :limit => 3
    end
    
    change_table :countries do |t|
      t.index :alpha_2_code
    end
  end
  
  def self.down
    drop_table :countries
  end
end
