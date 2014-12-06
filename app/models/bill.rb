class Bill < ActiveRecord::Base
  def get_vote(voter_id)
    Vote.where(bill_id: self.id,
               voter_id: voter_id).first
  end
end
