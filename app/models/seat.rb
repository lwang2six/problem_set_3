class Seat < ActiveRecord::Base
  validates :position, :uniqueness => true

  belongs_to :user
end
