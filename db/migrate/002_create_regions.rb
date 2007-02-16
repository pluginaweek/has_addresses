class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.column :country_id,   :integer, :null => false, :unsigned => true
      t.column :name,         :string,  :null => false, :limit => 50
      t.column :abbreviation, :string,  :null => false, :limit => 5
    end
    add_index :regions, [:name, :country_id],         :unique => true
    add_index :regions, [:abbreviation, :country_id], :unique => true
  end
  
  def self.down
    drop_table :regions
  end
  
  def self.bootstrap
    :regions
  end
end
