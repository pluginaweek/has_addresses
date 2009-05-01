class CreateRegions < ActiveRecord::Migration
  def self.up
    create_table :regions do |t|
      t.references :country, :null => false
      t.string :code, :name, :abbreviation, :null => false
      t.string :group
    end
    
    change_table :regions do |t|
      t.index :code
    end
  end
  
  def self.down
    drop_table :regions
  end
end
