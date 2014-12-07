class Voter < User
  validates :name, :address, :voter_id, :city, :zip, presence: true
end
