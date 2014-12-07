class Bill < ActiveRecord::Base
  def get_vote(voter_id)
    Vote.where(bill_id: self.id,
               voter_id: voter_id).first
  end

  def body
    self.senate ? "Senate" : "House"
  end

  def self.current
    where("current = ?", true)
  end
end
