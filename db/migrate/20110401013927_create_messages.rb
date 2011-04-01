class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :user_id
      t.text :msg
      t.datetime :timestamp

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
