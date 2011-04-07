class Message < ActiveRecord::Base
  validates :msg, :presence => true

  belongs_to :user
  belongs_to :chat
end
