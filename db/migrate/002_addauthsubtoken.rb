class Addauthsubtoken < ActiveRecord::Migration
  def self.up    
    add_column :users, :authsubtoken, :string
  end

  def self.down
  end
end
