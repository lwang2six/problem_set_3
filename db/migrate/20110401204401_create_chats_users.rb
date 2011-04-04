class CreateChatsUsers < ActiveRecord::Migration
  def self.up
    create_table :chats_users, :id => false do |t|
      t.references :user
      t.references :chat
    end
  end

  def self.down
    drop_table :chats_users
  end
end
