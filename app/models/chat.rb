class Chat < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :messages

  def time 
     "#{created_at.localtime.to_s(:long)}"
  end
end
