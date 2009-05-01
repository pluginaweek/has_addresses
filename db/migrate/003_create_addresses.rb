class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.references :addressable, :polymorphic => true, :null => false
      t.string :street_1, :null => false
      t.string :street_2
      t.string :city, :null => false
      t.references :region
      t.string :custom_region
      t.string :postal_code, :null => false
      t.references :country
      t.timestamps
    end
  end
  
  def self.down
    drop_table :addresses
  end
end
