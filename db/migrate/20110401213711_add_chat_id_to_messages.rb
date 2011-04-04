class AddChatIdToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :chat_id, :integer
  end

  def self.down
    remove_column :messages, :chat_id
  end
end
