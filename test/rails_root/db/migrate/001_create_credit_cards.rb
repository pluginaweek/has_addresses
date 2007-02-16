class CreateCreditCards < ActiveRecord::Migration
  def self.up
    create_table :credit_cards do |t|
      t.column :name,   :string
      t.column :number, :string
    end
  end
  
  def self.down
    drop_table :credit_cards
  end
  
  def self.bootstrap
    :credit_cards
  end
end
