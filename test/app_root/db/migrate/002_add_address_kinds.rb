class AddAddressKinds < ActiveRecord::Migration
  def self.up
    add_column :addresses, :kind, :string
  end
  
  def self.down
    remove_column :addresses, :kind
  end
end
