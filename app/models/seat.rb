class Seat < ActiveRecord::Base
  validates :position, :uniqueness => true

  belongs_to :user

  def place
    if position
      "Row #{position/8 + 1} Seat Number #{position%8}"
    else
      "Have not pick a seat yet!"
    end
  end

  def claimed_by?(claimer)
    return flase unless claimer.is_a? User
    user == claimer
  end
end
