class AddClientToAttack < ActiveRecord::Migration
  def self.up
    add_column :attacks, :client, :string
  end

  def self.down
    remove_column :attacks, :client
  end
end
