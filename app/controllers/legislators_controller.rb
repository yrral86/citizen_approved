class LegislatorsController < ApplicationController
  before_filter :authenticate_legislator!

  def home
    @bills = Bill.current
  end
end
