class VotesController < ApplicationController
  before_filter :authenticate_voter!

  def upcoming
    bills = Bill.current
    bill_ids = bills.map {|b| b.id}
    votes = Vote.where(bill_id: bill_ids, voter_id: current_voter.id)
    @voteless = []
    @voted = []
    bills.each do |b|
      s = votes.select do |v|
        v.bill_id == b.id
      end.size
      @voteless << b if s == 0
      @voted << b if s == 1
    end
  end

  def submit
    v = Vote.where(bill_id: params[:bill_id], voter_id: current_voter.id).first
    v = Vote.create(bill_id: params[:bill_id], voter_id: current_voter.id) unless v
    v.update(choice: params[:choice]) 
    render nothing: true
  end

  def compare
  end
end
