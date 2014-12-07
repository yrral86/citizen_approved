class Bill < ActiveRecord::Base
  has_many :votes

  def get_vote(voter_id)
    Vote.where(bill_id: self.id,
               voter_id: voter_id).first
  end

  def body
    self.senate ? "Senate" : "House"
  end

  def vote_count(constituants, type=:all)
    vote_list = votes.where(voter_id: constituants)
    if type == :all
      vote_list.size
    else
      vote_list.where(choice: type).size
    end
  end

  def self.current
    where("current = ?", true)
  end
end
