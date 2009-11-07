class CreateAttacks < ActiveRecord::Migration
  def self.up
    create_table :attacks do |t|
      t.string :chunk
      t.integer :offset
      t.integer :position
      t.integer :response
    end
  end

  def self.down
    drop_table :attacks
  end
end
